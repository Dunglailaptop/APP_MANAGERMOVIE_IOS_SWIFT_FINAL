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




class CustomTabBarViewController: UITabBarController {
    var viewModel = CustomBarViewModel()
    var router = CustomBarRouter()
    
    private let customTabBar = CustomTabBar()
    
    private let disposeBag = DisposeBag()
 
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        setupHierarchy()
        setupLayout()
        setupProperties()
        bind()
        view.layoutIfNeeded()
//
     
        
        
        
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
        // socket io here
        //        SocketIOManager.sharedInstance.initSocketInstance(String(format: "/restaurants_%d_branches_%d", ManageCacheObject.getCurrentUser().restaurant_id, ManageCacheObject.getCurrentUser().branch_id), false)
        
        // == End socket io
    }
    
    //    func connectSocketOauth(){
    //        if(ManageCacheObject.isLogin()){
    //            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
    //                if let url = URL(string:APIEndPoint.Name.REALTIME_SERVER) {
    //                    let auth = ["token": ManageCacheObject.getCurrentUser().jwt_token]
    //                    self.managerRealtime = SocketManager(socketURL: url, config: [.log(true), .compress, .reconnects(true)])
    //
    //                    self.socketRealtime = self.managerRealtime!.socket(forNamespace: String(format: "/restaurants_%d_branches_%d", ManageCacheObject.getCurrentUser().restaurant_id, ManageCacheObject.getCurrentUser().branch_id))
    //
    //
    //                    self.managerRealtime?.connectSocket(self.socketRealtime!, withPayload: auth)
    //
    //
    ////                    self.managerRealtime!.connect()
    //
    //                    self.socketRealtime!.on(clientEvent: .error) {data, ack in
    //                          print("socket error CustomTabBarController")
    //                        print(data)
    //                      }
    //
    //
    //
    //                }
    //            })
    //        }
    //
    //
    //    }
}
