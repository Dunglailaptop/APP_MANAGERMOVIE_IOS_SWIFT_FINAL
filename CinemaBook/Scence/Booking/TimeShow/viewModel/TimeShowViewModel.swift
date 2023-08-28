//
//  TimeShowViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 8/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TimeShowViewModel:BaseViewModel {
     private(set) weak var view: TimeShowViewController?
      private var router: TimeShowRouter?
      
      public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1])
      
      func bind(view: TimeShowViewController, router: TimeShowRouter)
      {
          self.view = view
          self.router =  router
          self.router?.setSourceView(self.view!)
      }
}
