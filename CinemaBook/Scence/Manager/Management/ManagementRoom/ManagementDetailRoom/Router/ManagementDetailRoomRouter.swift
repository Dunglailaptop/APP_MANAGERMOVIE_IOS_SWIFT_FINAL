//
//  ManagementDetailRoomRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 23/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementDetailRoomRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementDetailRoomViewController(nibName: "ManagementDetailRoomViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigationPopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }

    
  
}
