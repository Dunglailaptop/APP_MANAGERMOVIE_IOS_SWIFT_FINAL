//
//  AccountInfoViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import  UIKit
import RxSwift
import RxCocoa


class AccountInfoViewModel: BaseViewModel{
    private(set) weak var view: AccountInfoViewController?
    private var router: AccountInfoRouter?
    
    public var dataArray: BehaviorRelay<Users> = BehaviorRelay(value: Users())
    
    
    
    func bind(view: AccountInfoViewController, router: AccountInfoRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makePopToViewController() {
        router?.navigationPopToViewController()
    }
  
}
extension AccountInfoViewModel {
   
         func postUpdateAccount() -> Observable<APIResponse> {
            return appServiceProvider.rx.request(.UpdateAccount(iduser: dataArray.value.idusers, Fullname: dataArray.value.fullname, Email: dataArray.value.email, Phone: dataArray.value.phone, Birthday: dataArray.value.birthday, avatar: dataArray.value.avatar))
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
    
}
