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
    
    public var dataArray = BehaviorRelay<Users>(value: Users())
    public var fullname = BehaviorRelay<String>(value: "")
    public var dataArrayRole: BehaviorRelay<[Role]> = BehaviorRelay(value: [])
    
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
    func getInfoAccount() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getInfoAccount(id: dataArray.value.idusers))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
    }
    
    
         func postUpdateAccount() -> Observable<APIResponse> {
            dLog(image_request.value)
            return appServiceProvider.rx.request(.UpdateAccount(iduser: dataArray.value.idusers, Fullname: dataArray.value.fullname, Email: dataArray.value.email, Phone: dataArray.value.phone, Birthday: dataArray.value.birthday == "" ? "2001-09-27":dataArray.value.birthday, avatar: dataArray.value.avatar,Idrole: dataArray.value.idrole,address: dataArray.value.address, gender: dataArray.value.gender))
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
      func getListRole() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListRole)
        .filterSuccessfulStatusCodes()
        .mapJSON().asObservable()
        .showAPIErrorToast()
        .mapObject(type: APIResponse.self)
      }
    
    
    func CreateNewEmployee() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postCreateNewEmployee(newUser: dataArray.value))
           .filterSuccessfulStatusCodes()
           .mapJSON().asObservable()
           .showAPIErrorToast()
           .mapObject(type: APIResponse.self)
         }
    
}
