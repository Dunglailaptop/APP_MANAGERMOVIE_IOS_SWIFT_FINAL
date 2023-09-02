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
    
    public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1])
    
    func bind(view: AccountInfoViewController, router: AccountInfoRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
  
}
