//
//  DialogshowCheckinViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import RxRelay


class DialogshowCheckinViewModel {
    private(set) weak var view: DialogshowCheckinViewController?
    private var router: DialogshowCheckinRouter?
    
    public var branch_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var emplpoyee_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var order_session_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var datacheckin: BehaviorRelay<checkin> = BehaviorRelay(value: checkin())
    func bind(view: DialogshowCheckinViewController, router: DialogshowCheckinRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLoginViewController(){
        router?.navigateToLoginViewController()
    }
    
}
extension DialogshowCheckinViewModel{
 
    func checkins() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.checkin(checkins: datacheckin.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
   
}

