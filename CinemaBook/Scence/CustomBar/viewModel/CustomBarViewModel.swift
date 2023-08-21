//
//  CustomViewModel.swift
//  TechresOrder
//
//  Created by Kelvin on 13/01/2023.
//

import UIKit
import RxSwift
import RxCocoa


class CustomBarViewModel {
    private(set) weak var view: CustomViewController?
    private var router: CustomBarRouter?
    
    public var branch_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var emplpoyee_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var order_session_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    func bind(view: CustomViewController, router: CustomBarRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLoginViewController(){
        router?.navigateToLoginViewController()
    }
    
}
extension CustomBarViewModel{

    
   
}

