//
//  ManageBillAccountViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 15/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import  UIKit
import RxSwift
import RxCocoa


class ManageBillAccountViewModel {
    private(set) weak var view: ManageBillAccountViewController?
    private var router: ManageBillAccountRouter?
    
    public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1])
    
    func bind(view: ManageBillAccountViewController, router: ManageBillAccountRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makePopViewController() {
        router?.makePopToViewController()
    }
}
