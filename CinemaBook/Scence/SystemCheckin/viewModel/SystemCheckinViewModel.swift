//
//  SystemCheckinViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//



import UIKit
import RxCocoa
import RxSwift
import RxRelay

class SystemCheckinViewModel: BaseViewModel {
    private(set) weak var view: SystemCheckinViewController?
    private var router: SystemCheckinRouter?
    
    public var dataArray: BehaviorRelay<[Datacheckin]> = BehaviorRelay(value: [])
    public var pagigationcheckin: BehaviorRelay<(idcinema:Int,iduser:Int,timestart:String,timeend:String,type:Int)> = BehaviorRelay(value: (idcinema:ManageCacheObject.getCurrentUserInfo().idcinema,iduser:0,timestart:"",timeend:"",type:0))
    func bind(view: SystemCheckinViewController,router: SystemCheckinRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceview(view)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
}
extension SystemCheckinViewModel {
    func getlistcheck() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getlistcheckin(idcinema: pagigationcheckin.value.idcinema, iduser: pagigationcheckin.value.iduser, timestart: pagigationcheckin.value.timestart, timeend: pagigationcheckin.value.timeend, type: pagigationcheckin.value.type))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
