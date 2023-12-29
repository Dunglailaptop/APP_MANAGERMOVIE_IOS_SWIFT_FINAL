//
//  ManagementBillProductViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 16/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class ManagementBillticketViewModel: BaseViewModel {
    
    private(set) weak var view: ManagementBillticketViewController?
    private var router: ManagementBillticketRouter?
    
    public var dataArray: BehaviorRelay<[BillInfoAccount]> = BehaviorRelay(value: [])
    public var dataArraySearch: BehaviorRelay<[BillInfoAccount]> = BehaviorRelay(value: [])
    public var allvalue: BehaviorRelay<(dateFrom:String,dateTo:String,status:Int)> = BehaviorRelay(value: (dateFrom:Utils.getCurrentDateStringformatMysqlyymmdd(),dateTo:Utils.getCurrentDateStringformatMysqlyymmdd(),status:0))
    func bind(view: ManagementBillticketViewController, router: ManagementBillticketRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeToViewControllerDetailBill(bill: BillInfoAccount) {
        router?.navigationToDetailBill(bill: bill)
    }
 
    
    
}
extension ManagementBillticketViewModel {
    func getListAllBill() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListAllBill(idcinema: ManageCacheObject.getCurrentCinema().idcinema, status: allvalue.value.status,datefrom: allvalue.value.dateFrom,dateto: allvalue.value.dateTo))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
}
