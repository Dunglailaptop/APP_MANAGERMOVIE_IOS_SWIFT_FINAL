//
//  MangamentProductViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MangamentProductViewModel: BaseViewModel {
    private(set) weak var view: MangamentProductViewController?
    private var router: MangamentProductRouter?
    
    public var dataArray:BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,4,5,6,7,8,9,10])
    
    func bind(view: MangamentProductViewController, router: MangamentProductRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
    func makeToCreateViewController() {
        router?.navigationtocreateproduct()
    }
}

