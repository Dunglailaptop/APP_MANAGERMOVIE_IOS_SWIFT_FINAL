//
//  BookingChairViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import JonAlert
import SocketIO
import Starscream
import SwiftSignalRClient
import ObjectMapper

class BookingChairViewController: BaseViewController, WebSocketDelegate {
 
    
   
    

    @IBOutlet weak var view_collection_lblandlistbill: UIView!
    var viewModel = BookingChairViewModel()
    var router = BookingChairRouter()
    var dataChair = [chair]()
    var currentScale: CGFloat = 1.0
    var safeAreaInsets: UIEdgeInsets = .zero
     var originalCollectionViewSize: CGSize = .zero
    var type = 0
    var idcinema = 0
    var idroom = 0
    var idinterest = 0
    var idmovie = 0
    var namemovie = "" //ten phim trong quan ly hoa don
//    @IBOutlet weak var height_view_listbill: NSLayoutConstraint!
    //label
    @IBOutlet weak var height_view_payment: NSLayoutConstraint!
    @IBOutlet weak var lbl_name_cinema: UILabel!
    
    @IBOutlet weak var lbl_namemovie: UILabel!
    @IBOutlet weak var lbl_info_interest: UILabel!
    //view hidden
    @IBOutlet weak var view_height_info: NSLayoutConstraint!
   
    @IBOutlet weak var view_info_room: UIView!
    
    @IBOutlet weak var view_payment: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var view_collection: UICollectionView!
    
    @IBOutlet weak var collection_view_listbill: UICollectionView!
    @IBOutlet weak var view_of_collectionview: UIView!
    @IBOutlet weak var view_of_collection: UIView!
    
    @IBOutlet weak var lbl_price_chair: UILabel!
    @IBOutlet weak var scroll_view_zoom: UIScrollView!
    
    @IBOutlet weak var lbl_listbill_namemovie: UILabel!
    @IBOutlet weak var lbl_number_chair: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        view_of_collectionview.backgroundColor = ColorUtils.backgroudcolor()
        scroll_view_zoom.delegate = self
//        originalCollectionViewSize = view_collection.frame.size
//        view_collection.contentSize = CGSize(width: 100, height: 100)
//        NSLayoutConstraint.activate([
//            view_collection.topAnchor.constraint(equalTo: scroll_view_zoom.topAnchor, constant: 0),
//                 view_collection.leadingAnchor.constraint(equalTo: scroll_view_zoom.leadingAnchor,constant: 0),
//                 view_collection.trailingAnchor.constraint(equalTo: scroll_view_zoom.trailingAnchor,constant: 0),
//                 view_collection.bottomAnchor.constraint(equalTo: scroll_view_zoom.bottomAnchor,constant: 0)
//             ])
        
      resgisterCollection()
        binđDataTableCollectionView()
        resgiter()
         NotificationCenter.default.addObserver(self, selector: #selector(self.onDidReceiveNotification(_:)), name: NSNotification.Name("NotificationCallApi"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotification(_:)), name: NSNotification.Name("POPTOVIEW2"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any] {
             
//            viewModel.makePopToViewController()
            self.navigationController?.popViewController(animated: true)
//            self.callPopViewController()
//            let viewcell = BookingChairRouter().viewController
//            self.navigationController?.pushViewController(viewcell, animated: true)
            }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        testSocket()
            var data = viewModel.pagition.value
            data.idroom = idroom
            data.idinterest = idinterest
            data.idcinema = idcinema
            data.idmovie = idmovie
            viewModel.pagition.accept(data)
        
        if type == 1{
            self.view_info_room.isHidden = true
            self.view_payment.isHidden = true
            self.view_height_info.constant = 0
            self.collection_view_listbill.isHidden = true
            self.view_collection_lblandlistbill.isHidden = true
//            getListchairRoom()
        } else if type == 5{
            self.collection_view_listbill.isHidden = false
            self.view_collection_lblandlistbill.isHidden = false
//            self.view_height_info.constant = 150
            self.height_view_payment.constant = 120
            getlistbillRoom()
            getListchair()
        }
        else  {
                self.view_info_room.isHidden = false
                self.view_payment.isHidden = false
                self.view_height_info.constant = 40
            self.collection_view_listbill.isHidden = true
            self.view_collection_lblandlistbill.isHidden = true
            getListchair()
        }
      
        
    }
    
    @objc func onDidReceiveNotification(_ notification: Notification)
      {
       
          
        dLog(notification.userInfo?["userInfo"])
        var Idroom = notification.userInfo?["userInfo"]
        var data = viewModel.pagition.value
        data.idroom = Idroom as! Int
        viewModel.pagition.accept(data)
        getListchairRoom()
      }
    
   
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    
    @IBAction func btn_makeToBookingProductCombo(_ sender: Any) {
        var datafilter = viewModel.dataArray.value.filter{$0.isSelected == ACTIVE}
        if datafilter.count > 0 {
            viewModel.makeToBookingProductComboViewController(dataInfoMovie: viewModel.infoInterestMovie.value,datachairs: datafilter)
        }else {
            JonAlert.showError(message: "Vui lòng chọn ghế để thực hiện thanh toán")
        }
       
    }
    
    var socket: WebSocket!
      var isConnected = false
      let server = WebSocketServer()
    
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
              if  let data = Mapper<testsocket>().map(JSONString: string.replacingOccurrences(of: "\u{001E}", with: "")) {
                  var datachair = viewModel.dataArray.value
                  if data.arguments.count > 0 && data.target == "HOADONMOI" {
                    
                      datachair.enumerated().forEach{(index1,value1) in
                          data.arguments[0].tickets.enumerated().forEach{(index,value) in
                              dLog(value)
                              if value == value1.idchair {
                                  datachair[index1].isSelected = BILL
                              }
                          }
                      }
                      viewModel.dataArray.accept(datachair)
                      let notificationName = Notification.Name("reloaddatachair")
                      dLog(viewModel.dataArray.value)
                      let loginResponse = ["userInfo": ["Report_type": viewModel.dataArray.value
                                                       ]]
                      NotificationCenter.default.post(name: notificationName, object: nil, userInfo: loginResponse)
//                      getListchair()
//                      tableView.reloadData()
                      dLog(data)
                      if data.arguments[0].Idusers == ManageCacheObject.getCurrentUserInfo().idusers {
                          showNotification(ID: data.arguments[0].idbill)
                      }
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
      
      // MARK: Write Text Action
      
      @IBAction func writeText(_ sender: UIBarButtonItem) {
          let specialChar: Character = "\u{001E}"
          let initialJSONMessage = "{\"protocol\":\"json\",\"version\":1}" + String(specialChar)
          socket.write(string: initialJSONMessage)
      }
      
      // MARK: Disconnect Action
      
      @IBAction func disconnect(_ sender: UIBarButtonItem) {
          if isConnected {
              dLog("connect")
              sender.title = "Connect"
              socket.disconnect()
          } else {
              dLog("disconnect")
              sender.title = "Disconnect"
              socket.connect()
          }
      }
   
    
}
extension BookingChairViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return view_collection
    }
    
}
