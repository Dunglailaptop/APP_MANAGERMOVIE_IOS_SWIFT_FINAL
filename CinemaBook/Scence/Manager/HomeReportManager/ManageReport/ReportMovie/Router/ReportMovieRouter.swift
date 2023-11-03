//
//  ReportMovieRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 03/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ReportMovieRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ReportMovieViewController(nibName: "ReportMovieViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    func makePopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
//    func maketoManagementReportTicketAll() {
//        let viewreporticket = ReportTicketALLRouter().viewController
//        sourceView?.navigationController?.pushViewController(viewreporticket, animated: true)
//    }
 
}
