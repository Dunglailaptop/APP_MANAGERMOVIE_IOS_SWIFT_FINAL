//
//  MessageViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//


import UIKit
import RxCocoa
import RxSwift
import RxRelay

class MessageViewModel: BaseViewModel {
    
    private(set) weak var view: MessageViewController?
    private var router: MessageRouter?
    
    var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value:  [1,2,3,4])

    func bind(view: MessageViewController, router: MessageRouter){
           self.view = view
           self.router = router
           self.router?.setSourceView(self.view)
       }
    
    
    
    
}


