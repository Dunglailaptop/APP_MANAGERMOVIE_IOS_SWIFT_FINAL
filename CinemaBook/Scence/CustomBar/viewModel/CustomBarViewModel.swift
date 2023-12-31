//
//  CustomViewModel.swift
//  TechresOrder
//
//  Created by Kelvin on 13/01/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay


class CustomBarViewModel {
    private(set) weak var view: CustomTabBarViewController?
    private var router: CustomBarRouter?
    
    public var branch_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var emplpoyee_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var order_session_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var datacheckin: BehaviorRelay<checkin> = BehaviorRelay(value: checkin())
    func bind(view: CustomTabBarViewController, router: CustomBarRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLoginViewController(){
        router?.navigateToLoginViewController()
    }
    
}
extension CustomBarViewModel{
    func checksession() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.checksession)
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    func checkins() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.checkin(checkins: datacheckin.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
   
}

