//
//  CreateProductViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CreateProductViewModel: BaseViewModel {
    private(set) weak var view: CreateProductViewController?
    private var router: CreateProductRouter?
    
    public var dataArray:BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,4,5,6,7,8,9,10])
    
    func bind(view: CreateProductViewController, router: CreateProductRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
    
  
}
