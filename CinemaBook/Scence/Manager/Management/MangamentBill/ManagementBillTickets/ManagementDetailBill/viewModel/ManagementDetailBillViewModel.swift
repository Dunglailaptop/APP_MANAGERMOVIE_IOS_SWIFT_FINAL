//
//  ManagementDetailBillViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 26/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class ManagementDetailBillViewModel: BaseViewModel {
    
    private(set) weak var view: ManagementDetailBillViewController?
    private var router: ManagementDetailBillRouter?
    
    public var dataArrayticket: BehaviorRelay<[DetailTicket]> = BehaviorRelay(value: [])
    public var dataArrayfoodcombo: BehaviorRelay<[DetailFoodComboBill]> = BehaviorRelay(value: [])
    public var idbill: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var dataInfoBill: BehaviorRelay<detailBill> = BehaviorRelay(value: detailBill())
    
    func bind(view: ManagementDetailBillViewController, router: ManagementDetailBillRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    func makePopToViewController() {
        router?.navigationPopToViewController()
    }
    
    
}
extension ManagementDetailBillViewModel {
    func getListDetailBill() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailBillInManager(idbill: idbill.value))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
}
