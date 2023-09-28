//
//  OrderProductViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OrderProductViewModel: BaseViewModel {
    private(set) weak var view: OrderProductViewController?
    private var router: OrderProductRouter?
    
    public var dataArray:BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,4,5,6,7,8,9,10])
    
    func bind(view: OrderProductViewController, router: OrderProductRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
    
  
}

