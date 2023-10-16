//
//  ManageBillFoodAccountRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 16/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit

class ManageBillFoodAccountRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManageBillFoodAccountViewController(nibName: "ManageBillFoodAccountViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func makePopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func makeToManageDetailBillFoodAccountViewController(foodcombo: PaymentInfoBillFoodCombo) {
        let viewcell = ManageDetailBillFoodAccountRouter().viewController as! ManageDetailBillFoodAccountViewController
        viewcell.foodcombo = foodcombo
        sourceView?.navigationController?.pushViewController(viewcell, animated: true)
    }
    
}
