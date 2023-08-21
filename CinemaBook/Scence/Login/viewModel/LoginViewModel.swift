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
    
   var username = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")


}
extension LoginViewModel{
    func getLogin() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.Login(username: username.value, password: password.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
    func getConfig() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.config(username: username.value))
        .filterSuccessfulStatusCodes()
        .mapJSON().asObservable()
        .showAPIErrorToast()
        .mapObject(type: APIResponse.self)
    }
}
