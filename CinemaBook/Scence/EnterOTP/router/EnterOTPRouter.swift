//
//  EnterOTPRouter.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 02/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class EnterOTPRouter {
    var viewController:UIViewController{
        return createViewController()
    }
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = EnterOTPViewController(nibName: "EnterOTPViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    
    func navigateLoginViewController(username:String){
        let loginViewController = LoginRouter().viewController as! LoginViewController
        loginViewController.username = username
        sourceView?.navigationController?.pushViewController(loginViewController, animated: true)
    }
 
//    
//    func navigateToUpdatePasswordViewController(username:String,verifyCode: String, restaurant_brand_name:String){
//        let updatePasswordViewController = UpdatePasswordRouter().viewController as! UpdatePasswordViewController
//        updatePasswordViewController.verifyCode = verifyCode
//        updatePasswordViewController.username = username
//        updatePasswordViewController.restaurant_brand_name = restaurant_brand_name
//        sourceView!.navigationController?.pushViewController(updatePasswordViewController, animated: true)
//    }
    func makeToChangePasswordViewController(dataacc:Account) {
        let viewChangePassword = ChangePasswordRouter().viewController as! ChangePasswordViewController
        viewChangePassword.accdata = dataacc
        viewChangePassword.typecheck = 1
        sourceView?.navigationController?.pushViewController(viewChangePassword, animated: true)
    }
 
    
}
