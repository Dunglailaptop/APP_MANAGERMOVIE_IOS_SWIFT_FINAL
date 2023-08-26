//
//  BaseViewController.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//

import UIKit
import RxSwift
import ObjectMapper


class BaseViewController: UIViewController {
   var viewModels = BaseViewModel()
    var window: UIWindow?
    
    var mySceneDelegate: RestartApp?
    
    enum ExampleArray : String {
        
        case north, east, south, west,wests,westss,westsss
        
        static var allValues = [ExampleArray.north, .east, .south, .west, .wests, .westss, .westsss]
        
    }
    
    
    // MARK: - Variable -
    // ARC managment by rxswift (deinit)
    let rxbag = DisposeBag()
    
    
    var working_session = 0
    
    // MARK: - View Life Cycle -
    override open func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .white
        
        setNeedsStatusBarAppearanceUpdate()
        
        modalPresentationStyle = .fullScreen
        
        view.tintAdjustmentMode = .normal
        
        
        self.navigationController?.isNavigationBarHidden = true

      
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
   
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(!ManageCacheObject.isLogin()){
//            let loginViewController = LoginRouter().viewController
//            navigationController?.pushViewController(loginViewController, animated: true)
        }
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
//       
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        super.viewWillDisappear(animated)
    }
    
    func navigatorToRootViewController(){
        let viewController = CustomTabBarViewController()
       self.navigationController?.pushViewController(viewController, animated: true)
        
//        let frame = UIScreen.main.bounds
//       window = UIWindow(frame: frame)
//
//        navigationController!.setViewControllers([SplashScreenViewController()], animated: true)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
        
    }
   
    
   
    
    // MARK: - Memory Release -
    deinit {
        print("Memory Release : \(String(describing: self))\n" )
    }
}





extension BaseViewController{
    func loadMainView() {
        let viewController = CustomTabBarViewController()
        
        // This is to get the SceneDelegate object from your view controller
           // then call the change root view controller function to change to main tab bar
        
        
       self.navigationController?.pushViewController(viewController, animated: true)
        
   }
    func logout(){
        
       var user = Users()
        user.idusers = 0
        
       
        ManageCacheObject.setConfig(Config())
        ManageCacheObject.saveCurrentUserInfo(user)
                var viewControllers = navigationController?.viewControllers
                viewControllers?.removeAll()
        
        //        navigationController?.setViewControllers(viewControllers!, animated: true)
        
        let loginViewController = LoginRouter().viewController as! LoginViewController
        navigationController?.pushViewController(loginViewController, animated: true)
        
    }

    func restart()
    {
      let window = getWindow()
        self.navigationController!.setViewControllers([SplachScreenViewController()], animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
//        // iOS13 or later
//        if #available(iOS 13.0, *) {
//            let sceneDelegate = UIApplication.shared.connectedScenes
//                .first!.delegate as! ScenceDelegate
//            self.navigationController!.setViewControllers([SplachScreenViewController()], animated: true)
//            sceneDelegate.window!.rootViewController = navigationController
//        }
        
    }
    
    func getWindow() -> UIWindow? {
       return UIApplication.shared.keyWindow
   }
    
}
