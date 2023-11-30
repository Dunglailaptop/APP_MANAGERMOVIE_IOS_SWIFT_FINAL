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
    
    public var dataArrayBillPayment: BehaviorRelay<PaymentFoodCombo> = BehaviorRelay(value: PaymentFoodCombo())
    public var dataArrayFoodCombo: BehaviorRelay<[FoodCombo]> = BehaviorRelay(value : [])
    public var dataVoucher: BehaviorRelay<[voucher]> = BehaviorRelay(value: [])
    public var dataArrayBillPaymentHistory: BehaviorRelay<PaymentFoodCombo> = BehaviorRelay(value: PaymentFoodCombo())
    func bind(view: PaymentFoodComboViewController,router: PaymentFoodComboRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceview(view)
    }
    
    func maKeToViewController() {
        router?.makePopToViewController()
    }
    
    
}
extension PaymentFoodComboViewModel {
    func PaymentBillFoodCombo() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postPaymentBillFoodCombo(foodcombobill: dataArrayBillPayment.value))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
    func getListVoucher() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListVoucher)
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
