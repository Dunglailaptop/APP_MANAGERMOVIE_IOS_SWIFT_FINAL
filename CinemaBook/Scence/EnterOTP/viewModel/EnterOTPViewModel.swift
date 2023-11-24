//
//  EnterOTPViewModel.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 02/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class EnterOTPViewModel: BaseViewModel{
    private (set) weak var view: EnterOTPViewController?
    private var router: EnterOTPRouter?

    var OTPCode = BehaviorRelay<String>(value: "")
    var restaurant_brand_name = BehaviorRelay<String>(value: "")
    var username = BehaviorRelay<String>(value: "")
    var sessionString = BehaviorRelay<String>(value: "")
    var timeToLockOPTEnterView = BehaviorRelay<Int>(value: 0)
    var emails = BehaviorRelay<String>(value: "")
    var dataaccountforgotpass: BehaviorRelay<Account> = BehaviorRelay(value: Account())
    //dataccount new
    var dataAccount: BehaviorRelay<(username:String,password:String,fullname:String,emails:String,enteredOTP:String,iduser:Int)> = BehaviorRelay(value: (username:"",password:"",fullname:"",emails:"",enteredOTP:"",iduser:0))
    
    func bind(view:EnterOTPViewController, router: EnterOTPRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLoginViewController(username:String){
        router?.navigateLoginViewController(username: username)
    }
    
  
    func makeToChangePasswordViewController(){
        router?.makeToChangePasswordViewController(dataacc: dataaccountforgotpass.value)
    }
 

        
}

extension EnterOTPViewModel{
  
    func checkOTP() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.confrimOTP(emails: emails.value, enteredOTP: OTPCode.value,username: dataAccount.value.username,passwords: dataAccount.value.password,fullname: dataAccount.value.fullname))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }

    func checkOTPForgotPassword() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.confirmfogotAccount(emails: emails.value, enteredOTP: OTPCode.value, iduser: dataAccount.value.iduser))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }



    
}
