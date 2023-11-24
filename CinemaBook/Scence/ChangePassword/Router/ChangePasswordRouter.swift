//
//  ChangePasswordRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 23/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ChangePasswordRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func makeToLoginViewController() {
        let loginviewcontroller = LoginRouter().viewController
        sourceView?.navigationController?.pushViewController(loginviewcontroller, animated: true)
    }
    func makePopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
 
   
    
}
