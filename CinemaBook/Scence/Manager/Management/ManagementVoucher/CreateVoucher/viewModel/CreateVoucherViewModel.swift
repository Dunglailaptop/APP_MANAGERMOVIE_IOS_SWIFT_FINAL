//
//  CreateVoucherViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CreateVoucherViewModel: BaseViewModel{
    private(set) weak var view: CreateVoucherViewController?
    private var router: CreateVoucherRouter?
    
    public var dataArray: BehaviorRelay<[voucher]> = BehaviorRelay(value: [])
    public var dataVoucher: BehaviorRelay<voucher> = BehaviorRelay(value: voucher())
    
    func bind(view: CreateVoucherViewController, router: CreateVoucherRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makePopToViewController() {
        router?.navigationPopToViewController()
    }
    
  
}
extension CreateVoucherViewModel {
    func createVoucher() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.createNewVoucher(vouchers: dataVoucher.value))
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
    
    func updatevoucher()  -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.UpdateDetailVoucher(vouchers: dataVoucher.value))
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
    
    func getDetail() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getDetailVoucher(idvoucher: dataVoucher.value.idvoucher))
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
    }
}

