//
//  ManagementBillRoom.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 04/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementBillRoomRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementBillRoomViewController(nibName: "ManagementBillRoomViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigationmaketoInterest(idroom:Int) {
        let viewinterest = TimeShowRouter().viewController as! TimeShowViewController
        viewinterest.idroom = idroom
        sourceView?.navigationController?.pushViewController(viewinterest, animated: true)
    }
   
    
}
