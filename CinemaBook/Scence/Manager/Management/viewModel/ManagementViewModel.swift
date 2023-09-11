//
//  ManagementViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/11/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class ManagementViewModel: BaseViewModel{
    private(set) weak var view: ManagementViewController?
    private var router: ManagementRouter?
    
    public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1])
    
    func bind(view: ManagementViewController, router: ManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func navigationToManagementEmployee() {
        router?.navigationToManagementEmployee()
    }
    
}


