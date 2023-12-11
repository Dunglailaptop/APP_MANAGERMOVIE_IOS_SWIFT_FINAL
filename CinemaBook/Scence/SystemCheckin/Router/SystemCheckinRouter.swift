//
//  SystemCheckinRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//


import UIKit

class SystemCheckinRouter {
    var viewController:UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = SystemCheckinViewController(nibName: "SystemCheckinViewController", bundle: Bundle.main)
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
