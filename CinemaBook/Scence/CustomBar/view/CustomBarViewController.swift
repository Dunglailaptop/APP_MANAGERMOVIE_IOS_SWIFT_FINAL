//
//  CustomTabBarViewController.swift
//  CustomTabBarExample
//
//  Created by Jędrzej Chołuj on 18/12/2021.
//

import UIKit
import RxSwift

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
//        let redValue: CGFloat = 255.0 / 255.0 // Replace with your desired red value (0-255)
//        let greenValue: CGFloat = 255.0 / 255.0 // Replace with your desired green value (0-255)
//        let blueValue: CGFloat = 255.0 / 255.0 // Replace with your desired blue value (0-255)
//
//        let tabBarColor = UIColor(
//            red: redValue,
//            green: greenValue,
//            blue: blueValue,
//            alpha: 1.0 // The alpha value is set to 1.0 (fully opaque) by default
//        )
//        tabBar.isHidden = false
//        tabBar.barTintColor = .white
//        tabBar.layer.shadowRadius = 5.0
//        tabBar.layer.shadowColor =
//        tabBar.layer.cornerRadius = 10
      
       tabBar.isHidden = false
        tabBar.barTintColor = .white
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.5 // Use a valid value between 0 and 1
        tabBar.layer.shadowOffset = CGSize(width: 10, height: 10)
        tabBar.layer.shadowPath = UIBezierPath(roundedRect: tabBar.bounds, cornerRadius: 15).cgPath // Use roundedRect with corner radius
        tabBar.layer.cornerRadius = 15
        tabBar.clipsToBounds = true

        tabBar.layer.masksToBounds = false // Set this to false
        customTabBar.translatesAutoresizingMaskIntoConstraints = false

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
