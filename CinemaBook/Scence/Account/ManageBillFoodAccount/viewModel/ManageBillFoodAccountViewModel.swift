//
//  ManageBillFoodAccountViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 16/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//
import  UIKit
import RxSwift
import RxCocoa


class ManageBillFoodAccountViewModel {
    private(set) weak var view: ManageBillFoodAccountViewController?
    private var router: ManageBillFoodAccountRouter?
    
    public var dataArray: BehaviorRelay<[PaymentInfoBillFoodCombo]> = BehaviorRelay(value: [])
    
    func bind(view: ManageBillFoodAccountViewController, router: ManageBillFoodAccountRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makePopViewController() {
        router?.makePopToViewController()
    }
    func makeDetailBillFoodAccountViewController(foodcombo: PaymentInfoBillFoodCombo) {
        router?.makeToManageDetailBillFoodAccountViewController(foodcombo: foodcombo)
    }
    
}
extension ManageBillFoodAccountViewModel {
    func getListBillFoodCombo() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBillFoodCombo(iduser: ManageCacheObject.getCurrentUserInfo().idusers))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
    }
}

