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
    
    private(set) weak var view: ChatMessageViewController?
    private var router: ChatMessageRouter?
    
    var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value:  [1,2,3,4])

    func bind(view: ChatMessageViewController, router: ChatMessageRouter){
           self.view = view
           self.router = router
           self.router?.setSourceView(self.view)
       }
    

    
    
}
