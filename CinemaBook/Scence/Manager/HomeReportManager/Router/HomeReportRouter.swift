//
//  HomeReportRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class HomeReportRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = HomeReportViewController(nibName: "HomeReportViewController", bundle: Bundle.main)
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
    
    func makeToReportMovie() {
        let viewrportMovie = ReportMovieRouter().viewController
        sourceView?.navigationController?.pushViewController(viewrportMovie, animated: true)
    }
 
    func makeToReportfood() {
        let viewrportFOOD = ReportFoodRouter().viewController
        sourceView?.navigationController?.pushViewController(viewrportFOOD, animated: true)
    }
}

