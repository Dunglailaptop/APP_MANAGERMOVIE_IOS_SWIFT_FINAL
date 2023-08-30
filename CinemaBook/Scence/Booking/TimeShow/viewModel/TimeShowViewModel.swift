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
    
    public var dataListCinema: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14])
    public var listTime:BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,3,4,5,6,7,8,9,10])
    public var heightforcell: BehaviorRelay<Int> = BehaviorRelay(value: 80)
      
      func bind(view: TimeShowViewController, router: TimeShowRouter)
      {
          self.view = view
          self.router =  router
          self.router?.setSourceView(self.view!)
      }
    
    func navigationToBookingChairViewController() {
        router?.navigationToBookingChairViewController()
    }
    func navigationPopToViewController() {
        router?.makepopToViewController()
    }
}
