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
    
    public var dataArray:BehaviorRelay<[FoodCombo]> = BehaviorRelay(value: [])
    
    func bind(view: OrderProductViewController, router: OrderProductRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
    
  
}
extension OrderProductViewModel {
    func getListFoodCombo() -> Observable<APIResponse> {
          return appServiceProvider.rx.request(.getListFoodCombo)
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
}
