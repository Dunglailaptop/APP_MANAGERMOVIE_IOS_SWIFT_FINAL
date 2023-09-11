//
//  ManagementRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/11/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementViewController(nibName: "ManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    
    func navigationToManagementEmployee() {
        let managementemployee = ManagementEmployeeRouter().viewController
        sourceView?.navigationController?.pushViewController(managementemployee, animated: true)
    }
//    
//    func navigationToAccountInfoViewController() {
//        let accountinfoview = AccountInfoRouter().viewController
//        sourceView?.navigationController?.pushViewController(accountinfoview, animated: true)
//    }
    
}
