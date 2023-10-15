//
//  PaymentFoodComboViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 14/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper
import RxCocoa
import RxRelay
import RxSwift

class PaymentFoodComboViewModel: BaseViewModel {

    private(set) weak var view: PaymentFoodComboViewController?
    private var router: PaymentFoodComboRouter?
    
    
    public var dataArrayFoodCombo: BehaviorRelay<[FoodCombo]> = BehaviorRelay(value : [])
    
    func bind(view: PaymentFoodComboViewController,router: PaymentFoodComboRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceview(view)
    }
    
    func maKeToViewController() {
        router?.makePopToViewController()
    }
    
    
}
