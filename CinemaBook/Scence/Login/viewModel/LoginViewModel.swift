//
//  LoginViewModel.swift
//  CinemaBookTests
//
//  Created by dungtien on 7/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper
import RxCocoa
import Alamofire


class LoginViewModel {
    
    private(set) weak var view: LoginViewController?
    private var router: LoginRouter?
    private let disposeBag = DisposeBag()
    
    
    func bind(view: LoginViewController, router: LoginRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makeToMenuViewController(){
        router?.navigateToMenuViewController()
    }
    
    func makeToFogotPassword() {
        router?.navigateToFogotPassword()
    }
    
    var account: BehaviorRelay<Account> = BehaviorRelay(value: Account())
   var iduser = BehaviorRelay<Int>(value: 0)

}
extension LoginViewModel{
    func getLogin() -> Observable<APIResponse> {
    
        FireBaseManager.shared.LoginUser(email: "ndung983@gmail.com", password: "123456",username: account.value.username)
       
      
        return appServiceProvider.rx.request(.Login(username: account.value.username, password: account.value.password))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
    func getConfig() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.config(username: account.value.username))
        .filterSuccessfulStatusCodes()
        .mapJSON().asObservable()
        .showAPIErrorToast()
        .mapObject(type: APIResponse.self)
    }
     func getInfoCinema() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getInfoUserCinema(iduser: iduser.value ))
           .filterSuccessfulStatusCodes()
           .mapJSON().asObservable()
           .showAPIErrorToast()
           .mapObject(type: APIResponse.self)
       }
}
