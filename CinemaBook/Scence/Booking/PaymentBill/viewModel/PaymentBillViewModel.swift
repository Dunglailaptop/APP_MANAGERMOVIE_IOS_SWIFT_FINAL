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
    var dataVoucher:BehaviorRelay<[voucher]> = BehaviorRelay(value: [])
    var dataCombo:BehaviorRelay<[FoodCombo]> = BehaviorRelay(value: [])
    var databill: BehaviorRelay<Bill> = BehaviorRelay(value: Bill())
    var databillhistoryVoucher: BehaviorRelay<Bill> = BehaviorRelay(value: Bill())
    var idbill: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var paymentVNPAY: BehaviorRelay<(amount:Int,idorder:Int)> = BehaviorRelay(value: (amount:0,idorder:0))
    var title_header = BehaviorRelay<String>(value:  "")
    var link_website = BehaviorRelay<String>(value:  "")
    func bind(view: PaymentBillViewController,router: PaymentBillRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
    func makeToBookingChairViewController() {
        router?.makeToBookingChairView()
    }
    func makePopToSuccessPayment(){
        router?.makePopToViewControllerSuccessPayment()
    }
    func makePolicyViewController(){
        router?.navigateToPolicyViewController(title_header: title_header.value, link_website: link_website.value,idbilll: idbill.value)
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
    
    func postCreateBill() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.PostPaymentBill(bill: databill.value))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
    }
    
    func getPoint() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getPoint(iduser: ManageCacheObject.getCurrentUserInfo().idusers))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    func getIdbillPaymentVNPAY() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getIdbillPayment(idbill: idbill.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    func postpaymentVNPAY() -> Observable<APIResponse> {
        dLog(paymentVNPAY.value.amount)
        dLog(paymentVNPAY.value.idorder)
        return appServiceProvider.rx.request(.paymentVNPAY(amount: paymentVNPAY.value.amount, idorder: paymentVNPAY.value.idorder))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    func postSaveCacheVNPAYBILL() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.saveCacheVNPAY(bill: databill.value))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
    }
    
    func getListVoucher() -> Observable<APIResponse>
    {
        return appServiceProvider.rx.request(.getListVoucher)
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
        
    }
}
