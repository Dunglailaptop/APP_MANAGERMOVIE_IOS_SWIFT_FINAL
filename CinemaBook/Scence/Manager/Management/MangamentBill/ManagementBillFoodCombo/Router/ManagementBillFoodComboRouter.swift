//
//  ManagementBillFoodComboRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 17/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementBillFoodComboRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementBillFoodComboViewController(nibName: "ManagementBillFoodComboViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    func navigationToDetailProductFoodComboBill(PaymentBillfoodcombo: PaymentInfoBillFoodCombo) {
        let viewcell = ManageDetailBillFoodAccountRouter().viewController as! ManageDetailBillFoodAccountViewController
        viewcell.foodcombo = PaymentBillfoodcombo
        sourceView?.navigationController?.pushViewController(viewcell, animated: true)
    }
   
}
