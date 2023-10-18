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
    
    func bind(view: ManagementBillticketViewController, router: ManagementBillticketRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
 
    
    
}
extension ManagementBillticketViewModel {
    func getListAllBill() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListAllBill(idcinema: ManageCacheObject.getCurrentCinema().idcinema, status: 1))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
}
