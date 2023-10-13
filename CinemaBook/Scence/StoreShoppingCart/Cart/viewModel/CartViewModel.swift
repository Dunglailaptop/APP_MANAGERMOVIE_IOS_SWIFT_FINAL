//
//  CartViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 13/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class CartViewModel: BaseViewModel {
    private(set) weak var view: CartViewController?
    private var router: CartRouter?
    
    
    public var dataArrayFoodCombo:BehaviorRelay<[FoodCombo]> = BehaviorRelay(value: [])
    
    func bind(view: CartViewController,router: CartRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceview(view)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
   
    
}
