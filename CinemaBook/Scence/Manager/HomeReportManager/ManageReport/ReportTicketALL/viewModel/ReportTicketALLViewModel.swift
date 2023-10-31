//
//  ReportTicketALLViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 31/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ReportTicketALLViewModel: BaseViewModel{
    private(set) weak var view: ReportTicketALLViewController?
    private var router: ReportTicketALLRouter?
   
    func bind(view: ReportTicketALLViewController, router: ReportTicketALLRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makePopToViewController() {
        router?.makeToPopViewController()
    }
 
}
