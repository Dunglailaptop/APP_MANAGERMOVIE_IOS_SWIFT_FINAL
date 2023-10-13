//
//  CartRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 13/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class CartRouter {
    var viewController:UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = CartViewController(nibName: "CartViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceview(_ sourceview:UIViewController?){
        guard let view = sourceview else {fatalError("error")}
        self.sourceView = view
    }
    
    func makePopToViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
   
   
}
