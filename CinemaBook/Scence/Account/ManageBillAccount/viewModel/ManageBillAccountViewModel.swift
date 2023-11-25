//
//  ManageBillAccountViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 15/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import  UIKit
import RxSwift
import RxCocoa


class ManageBillAccountViewModel {
    private(set) weak var view: ManageBillAccountViewController?
    private var router: ManageBillAccountRouter?
    
    public var dataArray: BehaviorRelay<[BillInfoAccount]> = BehaviorRelay(value: [])
    public var dataArraySearch: BehaviorRelay<[BillInfoAccount]> = BehaviorRelay(value: [])
    public var status: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    func bind(view: ManageBillAccountViewController, router: ManageBillAccountRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makePopViewController() {
        router?.makePopToViewController()
    }
    
    func makeToDetailBillInfoAccount(BillInfo:BillInfoAccount) {
        router?.makeToDetailBillInfoAccount(BillDetailInfo: BillInfo)
    }
    
}
extension ManageBillAccountViewModel {
    func getListBillInAccount() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBillinAccount(iduser: ManageCacheObject.getCurrentUserInfo().idusers,status: status.value))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
    }
}
