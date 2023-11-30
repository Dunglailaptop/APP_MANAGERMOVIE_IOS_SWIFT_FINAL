//
//  SettingBusinessViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 30/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift

class SettingBusinessViewModel: BaseViewModel {
    
    private(set) weak var view: SettingBusinessViewController?
    private var router: SettingBusinessRouter?
   
    public var dataciema: BehaviorRelay<Cinema> = BehaviorRelay(value: Cinema())
    public var idcinema: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    func bind(view: SettingBusinessViewController, router: SettingBusinessRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makePopToViewController() {
        router?.makePopToViewController()
    }
 
    
 

}
extension SettingBusinessViewModel {
    func getDetailCinema() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailInfoCinema(idcinema: idcinema.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)

    }
    
    func updateCinemas() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getUpdateCinemaInfo(datacinema: dataciema.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
//
}
