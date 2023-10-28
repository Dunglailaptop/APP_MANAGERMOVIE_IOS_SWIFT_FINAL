//
//  ManagemetVoucherViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ManagementVoucherViewModel: BaseViewModel{
    private(set) weak var view: ManagementVoucherViewController?
    private var router: ManagementVoucherRouter?
    public var dataArraysearch: BehaviorRelay<[voucher]> = BehaviorRelay(value: [])
    public var dataArray: BehaviorRelay<[voucher]> = BehaviorRelay(value: [])
    
    func bind(view: ManagementVoucherViewController, router: ManagementVoucherRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makePopToViewController() {
        router?.navigationPopToViewController()
    }
    func makeToDetailViewController(idvoucher:Int,type:String) {
        router?.makeToDetailViewController(idvoucher: idvoucher,type: type)
    }
    
  
}
extension ManagementVoucherViewModel {
    func getListVoucherShowBanner() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListVoucher)
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
}
