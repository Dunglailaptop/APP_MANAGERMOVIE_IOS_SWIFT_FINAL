//
//  ManageReportViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 31/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class ManageReportViewModel: BaseViewModel{
    private(set) weak var view: ManageReportViewController?
    private var router: ManageReportRouter?
   
    func bind(view: ManageReportViewController, router: ManageReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makeToReportTicketViewController() {
        router?.maketoManagementReportTicketAll()
    }
    
    func makeToReportMovieViewController() {
        router?.makeToReportMovie()
    }
    func makeToReportFoodViewController() {
        router?.makeToReportfood()
    }
    
 
}


