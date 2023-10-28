//
//  ManagementVoucherRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementVoucherRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementVoucherViewController(nibName: "ManagementVoucherViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigationPopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func makeToDetailViewController(idvoucher: Int,type:String) {
        let viewcell = CreateVoucherRouter().viewController as! CreateVoucherViewController
        viewcell.idvoucher = idvoucher
        viewcell.type_check  = type
        sourceView?.navigationController?.pushViewController(viewcell, animated: true)
    }
   
}
