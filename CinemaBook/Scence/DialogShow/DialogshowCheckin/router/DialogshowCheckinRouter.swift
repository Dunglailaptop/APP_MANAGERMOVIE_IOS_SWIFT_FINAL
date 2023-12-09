//
//  DialogshowCheckinRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class DialogshowCheckinRouter {
    private var sourceView:UIViewController?
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToLoginViewController(){
        let loginViewController = LoginRouter().viewController
        sourceView?.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
}

