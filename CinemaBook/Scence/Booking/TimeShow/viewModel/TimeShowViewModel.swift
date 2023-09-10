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
    
    public var dataListCinema: BehaviorRelay<[InterestMovie]> = BehaviorRelay(value: [])
    public var listTime:BehaviorRelay<[InterestMovie]> = BehaviorRelay(value: [])
    public var heightforcell: BehaviorRelay<Int> = BehaviorRelay(value: 80)
    public var pagation: BehaviorRelay<(date:String,idmovie:Int)> = BehaviorRelay(value: (date: Utils().convertFormartDateyearMMdd(date: Date()) ,idmovie:1))
      
      func bind(view: TimeShowViewController, router: TimeShowRouter)
      {
          self.view = view
          self.router =  router
          self.router?.setSourceView(self.view!)
      }
    
    func navigationToBookingChairViewController(idcinema:Int,idroom:Int,idinterest:Int) {
        router?.navigationToBookingChairViewController(idcinema: idcinema, idroom: idroom, idinterest: idinterest)
    }
    func navigationPopToViewController() {
        router?.makepopToViewController()
    }
}
extension TimeShowViewModel {
      func getInterestMovie() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListInterestMovie(dateshow: pagation.value.date, idmovie: pagation.value.idmovie))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
         }
    func getListCinema() -> Observable<APIResponse> {
           return appServiceProvider.rx.request(.getListInterestCinema(dateshow: pagation.value.date, idmovie: pagation.value.idmovie))
                    .filterSuccessfulStatusCodes()
                    .mapJSON().asObservable()
                    .showAPIErrorToast()
                    .mapObject(type: APIResponse.self)
            }
}
