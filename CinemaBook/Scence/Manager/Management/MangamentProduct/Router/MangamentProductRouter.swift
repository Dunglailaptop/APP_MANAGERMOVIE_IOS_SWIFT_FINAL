//
//  MangamentProductRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class MangamentProductRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = MangamentProductViewController(nibName: "MangamentProductViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
   func navigationtocreateproduct() {
         let viewcreateproduct = CreateProductRouter().viewController as! CreateProductViewController
       viewcreateproduct.type = "CREATE"
    sourceView?.navigationController?.pushViewController(viewcreateproduct, animated: true)
     }
    func navigationPopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
  
}
