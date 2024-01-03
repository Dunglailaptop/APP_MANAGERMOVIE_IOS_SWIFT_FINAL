//
//  DialogShowCommentViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import Starscream
import ObjectMapper
import SocketIO

class DialogShowCommentViewController: BaseViewController {
    
    @IBOutlet weak var view_chat: UIView!
    @IBOutlet weak var lbl_number_comments: UILabel!
    @IBOutlet weak var txt_message: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var datacomments = [Comments]()
    var messages = ""
    var viewModel = DialogShowCommentViewModel()
    var router = DialogShowCommentRouter()
    var Idvideo = 0
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
      register()
        bindingtable()
        _ = txt_message.rx.text.map{(str) in
            if str!.count > 50 {
            
            }
            return String(str!.prefix(50))
        }.map({(str) -> MessageComments in
            self.txt_message.text = str
            var cloneEmployeeInfor = self.viewModel.datacreatemessage.value
            cloneEmployeeInfor.message = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.datacreatemessage).disposed(by: rxbag)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.view_chat)
        if !view_chat.bounds.contains(tapLocation) {
          dismiss(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var datacreatemessage = viewModel.datacreatemessage.value
        datacreatemessage.idvideo = Idvideo
        viewModel.datacreatemessage.accept(datacreatemessage)
        viewModel.datacomment.accept(datacomments)
        testSocket()
        tableview.reloadData()
        lbl_number_comments.text = String(viewModel.datacomment.value.count) + " Comment"
    }
   
//    var viewModel: VideoTraillerShowViewModel? = nil {
//        didSet {
//            register()
//             bindingtable()
////            viewModel?.datacomment.accept(datacomments)
//            dLog(viewModel?.datacomment.value)
//            tableview.reloadData()
//            _ = txt_message.rx.text.map{$0 ?? ""}.bind(to: messages).disposed(by: rxbag)
//        }
//    }
    @IBAction func btn_createMessage(_ sender: Any) {
        postMessage()
    }
    
}
extension DialogShowCommentViewController: UITableViewDelegate {
    func register() {
        let cell = UINib(nibName: "itemMesschatTableViewCell", bundle: .main)
        tableview.register(cell, forCellReuseIdentifier: "itemMesschatTableViewCell")
        tableview.separatorStyle = .none
        tableview.rx.setDelegate(self)
    }
    
    func bindingtable() {
        viewModel.datacomment.bind(to: tableview.rx.items(cellIdentifier: "itemMesschatTableViewCell", cellType: itemMesschatTableViewCell.self)) {
            (row,data,cell) in
            cell.selectionStyle = .none
            cell.data = data
         }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension DialogShowCommentViewController {
   
    
    func postMessage() {
        viewModel.postmessage().subscribe(onNext: {
            [self] response in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                
            }
        })
    }
}
extension DialogShowCommentViewController:WebSocketDelegate{
    
    
    func testSocket() {
        var request = URLRequest(url: URL(string: urlinksocketdeveloper)!) //https://localhost:8080
              request.timeoutInterval = 5
              socket = WebSocket(request: request)
              socket.delegate = self
              socket.connect()

    }
    // MARK: - WebSocketDelegate
      func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
          dLog(event)
          switch event {
          case .connected(let headers):
              isConnected = true
              dLog("websocket is connected: \(headers)")
              let specialChar: Character = "\u{001E}"
              let initialJSONMessage = "{\"protocol\":\"json\",\"version\":1}" + String(specialChar)
              socket.write(string: initialJSONMessage)
          case .disconnected(let reason, let code):
              isConnected = false
              dLog("websocket is disconnected: \(reason) with code: \(code)")
          case .text(let string):
              dLog("Received text: \(string)")
              if  let data = Mapper<socketmessage>().map(JSONString: string.replacingOccurrences(of: "\u{001E}", with: "")) {
                  var datachair = viewModel.datacomment.value
                  if data.arguments.count > 0 && data.target == "MESSAGE" {
                      dLog(data.arguments)
                      datachair.append(data.arguments[0])
                      viewModel.datacomment.accept(datachair)
                          // Ensure tableview updates are performed on the main thread
                      DispatchQueue.main.async { [self] in
                              self.tableview.reloadData()
                              lbl_number_comments.text = String(viewModel.datacomment.value.count) + " Comment"
                          }
//                      if let datanew = Mapper<Comments>().mapArray(JSONObject: data.arguments) {
//                          // Assuming Comments is a struct or class, create a new instance only if needed
//                          // var datanew = Comments() // Remove this line as it's replaced by the optional binding above
//
//                        
//                          viewModel.datacomment.accept(datachair)
//                          // Ensure tableview updates are performed on the main thread
//                          DispatchQueue.main.async {
//                              self.tableview.reloadData()
//                          }
//                      } else {
//                          // Handle the case where data.arguments[0] is not of type Comments
//                          dLog("Error: Unable to cast data.arguments[0] to Comments")
//                      }
                  }
                  
              }
             
          case .binary(let data):
              dLog("Received data: \(data.count)")
          case .ping(_):
              break
          case .pong(_):
              break
          case .viabilityChanged(_):
              break
          case .reconnectSuggested(_):
              break
          case .cancelled:
              isConnected = false
          case .error(let error):
              isConnected = false
              handleError(error)
          case .peerClosed:
              break
          }
      }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            dLog("websocket encountered an error: \(e.message)")
        } else if let e = error {
            dLog("websocket encountered an error: \(e.localizedDescription)")
        } else {
            dLog("websocket encountered an error")
        }
    }
}
