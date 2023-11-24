//
//  ChangePasswordViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 23/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift


class ChangePasswordViewModel: BaseViewModel {
    
    private(set) weak var view: ChangePasswordViewController?
    private var router: ChangePasswordRouter?
    public var dataaccount: BehaviorRelay<Account> = BehaviorRelay(value: Account())
    
    func bind(view: ChangePasswordViewController, router: ChangePasswordRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makeToLoginViewController() {
        router?.makeToLoginViewController()
    }
    func makePopToViewController() {
        router?.makePopToViewController()
    }
 

}
extension ChangePasswordViewModel {
    func changePassword() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.changepassword(newpassword: dataaccount.value.password, username: dataaccount.value.username))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
   

}
