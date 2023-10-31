//
//  ManageReportRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 31/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManageReportRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManageReportViewController(nibName: "ManageReportViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func maketoManagementReportTicketAll() {
        let viewreporticket = ReportTicketALLRouter().viewController
        sourceView?.navigationController?.pushViewController(viewreporticket, animated: true)
    }
 
}
