//
//  ManageDetailBillFoodAccountViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 16/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import  UIKit
import RxSwift
import RxCocoa


class ManageDetailBillFoodAccountViewModel {
    private(set) weak var view: ManageDetailBillFoodAccountViewController?
    private var router: ManageDetailBillFoodAccountRouter?
    
    public var dataArray: BehaviorRelay<[FoodCombo]> = BehaviorRelay(value: [])
    public var datafood: BehaviorRelay<[listfoodaddbill]> = BehaviorRelay(value: [])
    
    func bind(view: ManageDetailBillFoodAccountViewController, router: ManageDetailBillFoodAccountRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makePopViewController() {
        router?.makePopToViewController()
    }
}
extension ManageDetailBillFoodAccountViewModel {
   
}
