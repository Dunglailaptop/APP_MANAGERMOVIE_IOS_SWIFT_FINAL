//
//  PaymentBillViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 10/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PaymentBillViewModel: BaseViewModel {
    private(set) weak var view: PaymentBillViewController?
    private var router: PaymentBillRouter?
    
    var idmovie: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var dataArray: BehaviorRelay<[FoodCombo]> = BehaviorRelay(value: [])
    var dataArrayCombo:BehaviorRelay<[FoodCombo]> = BehaviorRelay(value: [])
    var dataCombo:BehaviorRelay<[FoodCombo]> = BehaviorRelay(value: [])
    func bind(view: PaymentBillViewController,router: PaymentBillRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
    
    
}
extension PaymentBillViewModel {
    func getListFoodCombo() -> Observable<APIResponse> {
               return appServiceProvider.rx.request(.getListFoodCombo)
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}