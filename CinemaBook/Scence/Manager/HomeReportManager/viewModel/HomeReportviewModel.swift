//
//  HomeReportviewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeReportviewModel: BaseViewModel{
    private(set) weak var view: HomeReportViewController?
    private var router: HomeReportRouter?
    
    public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2])
    
    func bind(view: HomeReportViewController, router: HomeReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
 
}


