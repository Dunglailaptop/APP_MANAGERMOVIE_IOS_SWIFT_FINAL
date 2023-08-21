
//
//  SplashScreenRouter.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 14/01/2023.
//

import UIKit
import RxSwift
class SplashScreenRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = SplachScreenViewController(nibName: "SplashScreenViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToLoginViewController(){
        let loginViewController = LoginRouter().viewController as! LoginViewController
        sourceView?.navigationController?.pushViewController(loginViewController, animated: true)
    }
    func navigateToMainViewController(){
//        let mainViewController = CustomTabBarViewController()
        let mainViewController = CustomTabBarViewController()
        sourceView?.navigationController?.pushViewController(mainViewController, animated: true)
    }
}
