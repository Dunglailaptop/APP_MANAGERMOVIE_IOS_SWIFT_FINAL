//
//  SigninRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class SigninRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = SigninViewController(nibName: "SigninViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    
    func makeToOTPViewController(emails:String) {
        let viewOTP = EnterOTPRouter().viewController as! EnterOTPViewController
        viewOTP.emails = emails
        sourceView?.navigationController?.pushViewController(viewOTP, animated: true)
    }
 
    
}
