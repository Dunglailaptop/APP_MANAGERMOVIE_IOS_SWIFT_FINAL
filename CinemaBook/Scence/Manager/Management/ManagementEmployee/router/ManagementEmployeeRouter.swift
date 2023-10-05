//
//  ManagementEmployeeRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/11/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementEmployeeRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementEmployeeViewController(nibName: "ManagementEmployeeViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigationtoAccountInfoViewController(iduser:Int,note:String) {
        let viewcontrolleracc = AccountInfoRouter().viewController as! AccountInfoViewController
        viewcontrolleracc.type_dy = note
        viewcontrolleracc.idUser = iduser
        sourceView?.navigationController?.pushViewController(viewcontrolleracc, animated: true)
    }
    func navigationPoptoview() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    
}
