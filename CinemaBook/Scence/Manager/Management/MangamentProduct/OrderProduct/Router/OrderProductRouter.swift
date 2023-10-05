//
//  OrderProductRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class OrderProductRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = OrderProductViewController(nibName: "OrderProductViewController", bundle: Bundle.main)
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
    func maketoDetailviewController(foodcombos:FoodCombo) {
        let viewcreateproduct = CreateProductRouter().viewController as! CreateProductViewController
        viewcreateproduct.foodcombo = foodcombos
        viewcreateproduct.type = "UPDATE"
              sourceView?.navigationController?.pushViewController(viewcreateproduct, animated: true)
    }
  
}
