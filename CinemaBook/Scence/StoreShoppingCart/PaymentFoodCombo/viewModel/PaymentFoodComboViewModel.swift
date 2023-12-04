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
    public var title_header: BehaviorRelay<String> = BehaviorRelay(value: "")
    public var link_website: BehaviorRelay<String> = BehaviorRelay(value: "")
    func bind(view: PaymentFoodComboViewController,router: PaymentFoodComboRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceview(view)
    }
    
    func maKeToViewController() {
        router?.makePopToViewController()
    }
    func makePolicyViewController(){
        router?.navigateToPolicyViewController(title_header: title_header.value, link_website: link_website.value,idbilll: 0)
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
    func saveCacheBillFoodCombo() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.saveCacheBillFood(datapaymentBillfood: dataArrayBillPayment.value))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
    func createLinkVNPAY() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.createLinkVNPAYBILLFOODCOMBO(amount: dataArrayBillPayment.value.total_price, idorder: 0))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
    func checkIdbillFoodCombo() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.chekcBillFood(idbill: dataArrayBillPayment.value.id))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}
