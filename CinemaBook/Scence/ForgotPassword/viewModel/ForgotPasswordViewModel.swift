//
//  ForgotPasswordViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 23/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift


class ForgotPasswordViewModel: BaseViewModel {
    
    private(set) weak var view: ForgotPasswordViewController?
    private var router: ForgotRouter?
  
    public var dataAccount: BehaviorRelay<Account> = BehaviorRelay(value: Account())
    func bind(view: ForgotPasswordViewController, router: ForgotRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makeToOTPenter() {
        router?.makeToOTPviewController(iduser: dataAccount.value.id,emails: dataAccount.value.emails)
    }
 

}
extension ForgotPasswordViewModel {
    func getOTP() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getOTPInEmail(emails: dataAccount.value.emails))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
   
    
    func searchaccountforgotpassword() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getForgotPassword(username: dataAccount.value.username))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
