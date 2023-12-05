//
//  NotifcationMessageViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 06/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class NotifcationMessageViewModel: BaseViewModel {
    
    private(set) weak var view: NotifcationMessageViewController?
    private var router: NotifcationMessageRouter?
    
    var dataArray: BehaviorRelay<[notifaction]> = BehaviorRelay(value:  [])
    var dataArraysearch: BehaviorRelay<[notifaction]> = BehaviorRelay(value:  [])
    var type: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    func bind(view: NotifcationMessageViewController, router: NotifcationMessageRouter){
           self.view = view
           self.router = router
           self.router?.setSourceView(self.view)
       }
    

    
    
}
extension NotifcationMessageViewModel {
    func getNotiCationMessage() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getNoTiFaction(iduser: ManageCacheObject.getCurrentUserInfo().idusers,type: type.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .mapObject(type: APIResponse.self)
    }
}
