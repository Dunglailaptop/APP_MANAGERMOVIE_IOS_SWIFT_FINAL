//
//  MangementRoomCreateRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/25/23.
//  Copyright © 2023 dungtien. All rights reserved.
//


import UIKit

class MangementRoomCreateRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementRoomCreateViewController(nibName: "ManagementRoomCreateViewController", bundle: Bundle.main)
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
