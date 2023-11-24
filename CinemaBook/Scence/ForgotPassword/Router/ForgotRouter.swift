//
//  ForgotRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 23/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ForgotRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    func makeToOTPviewController(iduser:Int,emails:String) {
        let viewOTP = EnterOTPRouter().viewController as! EnterOTPViewController
        viewOTP.typecheck = 1
        viewOTP.iduser = iduser
        viewOTP.emails = emails
        sourceView?.navigationController?.pushViewController(viewOTP, animated: true)
    }
   
    
}
