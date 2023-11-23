//
//  SigninViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxRelay
import RxCocoa
import RxSwift


class SigninViewModel: BaseViewModel {
    
    private(set) weak var view: SigninViewController?
    private var router: SigninRouter?
    var accesspassword: BehaviorRelay<String> = BehaviorRelay(value: "")
    var password: BehaviorRelay<String> = BehaviorRelay(value: "")
    var username: BehaviorRelay<String> = BehaviorRelay(value: "")
    var fullname: BehaviorRelay<String> = BehaviorRelay(value: "")
    var email: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    func bind(view: SigninViewController, router: SigninRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makeToOTPViewController() {
        router?.makeToOTPViewController(emails: email.value,username: username.value,password: password.value,Fullname: fullname.value)
    }
    
 

}
extension SigninViewModel {
    func getOTP() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getOTPInEmail(emails: email.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    func checkaccount() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getcheckaccountExistsSigin(username: username.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }

}
