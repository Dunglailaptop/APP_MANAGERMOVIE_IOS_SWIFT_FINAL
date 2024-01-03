//
//  AccountViewController.swift
//  CinemaBook
//
//  Created by dungtien on 7/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SKPhotoBrowser
import Kingfisher
import Starscream
import ObjectMapper

class AccountViewController: BaseViewController {
    
    @IBOutlet weak var lbl_username_account: UILabel!
    @IBOutlet weak var lbl_point_account: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_name: UILabel!
    
    var viewModel = AccountViewModel()
    var router = AccountRouter()
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        register()
        bindingtableview()
        setup()
        if ManageCacheObject.getCurrentUserInfo().idrole == 2 || ManageCacheObject.getCurrentUserInfo().idrole == 3 {
            viewModel.dataArray.accept([0,1])
        }else {
            viewModel.dataArray.accept([0,1,2])
        }
      testSocket()
        // Do any additional setup after loading the view.
    }
  

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_point_account.text = Utils.stringQuantityFormatWithNumber(amount: ManageCacheObject.getCurrentUserInfo().point)
        lbl_username_account.text = ManageCacheObject.getCurrentUserInfo().username
    }


    @IBAction func btn_actionlogout(_ sender: Any) {
    

        self.logout()
        

    }

    
    func setup(){
        lbl_name.text = ManageCacheObject.getCurrentUserInfo().fullname
        avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: ManageCacheObject.getCurrentUserInfo().avatar)), placeholder:  UIImage(named: "image_defauft_medium"))
    }
    
    @IBAction func bnt_makeToAccountinfoviewcontroller(_ sender: Any) {
        viewModel.makeToAccountInfoViewController()
    }
}
extension AccountViewController: WebSocketDelegate {
    func testSocket() {
        var request = URLRequest(url: URL(string: urlinksocketdeveloper)!) //https://localhost:8080
              request.timeoutInterval = 5
              socket = WebSocket(request: request)
              socket.delegate = self
              socket.disconnect()
              socket.connect()
//              sendCustomMessage()
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
              if isConnected  {
                  sendCustomMessage()
                  isConnected = false
                
              }
            
              if  let data = Mapper<socketNotifcation>().map(JSONString: string.replacingOccurrences(of: "\u{001E}", with: "")) {
//                  var datachair = viewModel.datacomment.value
                  dLog(data)
                  if data.arguments.count > 0 && data.target == "MESSAGENOTIFACTION" {
                      dLog(data.arguments)
                      let notificationName = Notification.Name("MESSAGENOTIFACTION")
                      let loginResponse = ["userInfo": ["Report_type": data.arguments[0]]]
                      NotificationCenter.default.post(name: notificationName, object: nil, userInfo: loginResponse)
//                      count += 1
                
                     
//                     isConnected = false
                      socket.disconnect()
                  }
                  
              }
           
//              socket.write(string: "ok")
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
    func sendCustomMessage() {
        let specialChar: Character = "\u{001E}"
        let ManageIdUsers = ManageCacheObject.getCurrentUserInfo().idusers
        let idrole = ManageCacheObject.getCurrentUserInfo().idrole
        let customMessage = "{\"arguments\":[\"\(ManageIdUsers)\",\(idrole)],\"target\":\"SendNotifaction\",\"type\":1}" + String(specialChar)
        dLog(customMessage)
        sendMessage(customMessage)
    }
    func sendMessage(_ message: String) {
        if isConnected { // Kiểm tra nếu đang kết nối với WebSocket
            socket.write(string: message)
        } else {
            // Xử lý trường hợp không kết nối với WebSocket
            dLog("WebSocket is not connected. Cannot send message.")
            socket.disconnect()
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
