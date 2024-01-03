//
//  CustomTabBarViewController.swift
//  CustomTabBarExample
//
//  Created by Jędrzej Chołuj on 18/12/2021.
//

import UIKit
import RxSwift
import JonAlert
import ObjectMapper
import Starscream




class CustomTabBarViewController: UITabBarController {
    var viewModel = CustomBarViewModel()
    var router = CustomBarRouter()
    
    private let customTabBar = CustomTabBar()
    
    private let disposeBag = DisposeBag()
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    
    var count = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        setupHierarchy()
        setupLayout()
        setupProperties()
        bind()
        view.layoutIfNeeded()
//
     
        testSocket()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = true
        
        if(!ManageCacheObject.isLogin()){
            dLog("Not Login...........")
            let loginViewController = LoginRouter().viewController
            navigationController?.pushViewController(loginViewController, animated: true)
            NotificationCenter.default.post(Notification(name: .refreshAllTabs))
        }
        // THỰC HIỆN CONNECT SOCKET IO TRƯỚC KHI BẮT ĐẦU CÁC CHỨC NĂNG
        //       setupSocketIO()
        if (ManageCacheObject.getCurrentUserInfo().idrole == 3) {
            checksession()
        }
        
    }
    
    private func setupHierarchy() {
        view.addSubview(customTabBar)
    }
    
    private func setupLayout() {
        customTabBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(0)
            $0.height.equalTo(80)
        }
    }
    
    private func setupProperties() {
     tabBar.isHidden = true
        
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.addShadow()
       
        selectedIndex = 0

        let controllers = CustomTabItem.allCases.map { $0.viewController }
        setViewControllers(controllers, animated: true)
    }
    
    
    
    private func selectTabWith(index: Int) {
        self.selectedIndex = index
    }
    
    //MARK: - Bindings
    
    private func bind() {
        customTabBar.itemTapped
            .bind { [weak self] in self?.selectTabWith(index: $0) }
            .disposed(by: disposeBag)
    }
}


extension Notification.Name {
    static let refreshAllTabs = Notification.Name("RefreshAllTabs")
}
extension CustomTabBarViewController {
    func checksession() {
        viewModel.checksession().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
             
                var dataacc = self.viewModel.datacheckin.value
                dataacc.timestart = "2023-12-08T16:06:22.449Z"
                dataacc.timeend = "2023-12-08T16:06:22.449Z"
                dataacc.checksession = 1
                dataacc.idusers = ManageCacheObject.getCurrentUserInfo().idusers
                dataacc.idcinema = ManageCacheObject.getCurrentCinema().idcinema
                self.viewModel.datacheckin.accept(dataacc)
                self.presentModalDialogConfirmWorkingSessionViewController(lbl_tittle: response.message ?? "",checkins: self.viewModel.datacheckin.value)
                
               
            } else if response.code == 300 {
                dLog(response.message)
                   var dataacc = self.viewModel.datacheckin.value
                   dataacc.timestart = "2023-12-08T16:06:22.449Z"
                   dataacc.timeend = "2023-12-08T16:06:22.449Z"
                   dataacc.checksession = 1
                   dataacc.idusers = ManageCacheObject.getCurrentUserInfo().idusers
                   dataacc.idcinema = ManageCacheObject.getCurrentCinema().idcinema
                   self.viewModel.datacheckin.accept(dataacc)
                   self.presentModalDialogConfirmWorkingSessionViewController(lbl_tittle: response.message ?? "",checkins: self.viewModel.datacheckin.value)
            } else {
                dLog(response.message)
            }
        })
    }
}

extension CustomTabBarViewController {
    
    func presentModalDialogConfirmWorkingSessionViewController(lbl_tittle:String,checkins:checkin) {
        let dialogConfirmWorkingSessionViewController = DialogshowCheckinViewController()

        dialogConfirmWorkingSessionViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogConfirmWorkingSessionViewController.lbl_info.text = lbl_tittle
        dialogConfirmWorkingSessionViewController.checkins = checkins
        dialogConfirmWorkingSessionViewController.type = 1
//        dialogConfirmWorkingSessionViewController.delegate = self
            let nav = UINavigationController(rootViewController: dialogConfirmWorkingSessionViewController)
            // 1
            nav.modalPresentationStyle = .overCurrentContext

            
            // 2
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    
                    // 3
                    sheet.detents = [.large()]
                    
                }
            } else {
                // Fallback on earlier versions
            }
            // 4
           
            present(nav, animated: true, completion: nil)

        }
    
    
    func setupSocketIO(){
      
    }
    
  
}
extension CustomTabBarViewController: WebSocketDelegate {

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
                  count += 1
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
