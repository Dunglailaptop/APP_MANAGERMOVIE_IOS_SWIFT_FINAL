//
//  ManagementEmployeeViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/11/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ManagementEmployeeViewModel: BaseViewModel{
    private(set) weak var view: ManagementEmployeeViewController?
    private var router: ManagementEmployeeRouter?
    
    public var dataArray: BehaviorRelay<[Users]> = BehaviorRelay(value: [])
    
    public var pagation: BehaviorRelay<(iduser:Int,keysearch:String,idcinema:Int)> = BehaviorRelay(value: (iduser:1,keysearch:"",idcinema:1))
    
    func bind(view: ManagementEmployeeViewController, router: ManagementEmployeeRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makeToAccountinfo(iduser:Int,note:String) {
        router?.navigationtoAccountInfoViewController(iduser:iduser, note: note)
    }
    func makePopTovViewController() {
        router!.navigationPoptoview()
    }
    func cleardata() {
        dataArray.accept([])
    }
    
    
}
extension ManagementEmployeeViewModel {
    func getListEmployee() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListEmployee(iduser: pagation.value.iduser , keysearch: pagation.value.keysearch, idcinema: pagation.value.idcinema))
                           .filterSuccessfulStatusCodes()
                           .mapJSON().asObservable()
                           .showAPIErrorToast()
                           .mapObject(type: APIResponse.self)
       }
}
