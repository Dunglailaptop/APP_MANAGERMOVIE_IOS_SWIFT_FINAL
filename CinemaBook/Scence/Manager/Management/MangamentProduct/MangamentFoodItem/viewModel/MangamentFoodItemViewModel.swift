//
//  MangamentFoodItemViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MangamentFoodItemViewModel: BaseViewModel {
    private(set) weak var view: MangamentFoodItemViewController?
    private var router: MangamentFoodItemRouter?
    public var idcategory: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var dataArray: BehaviorRelay<[Food]> = BehaviorRelay(value: [])
    
    func bind(view: MangamentFoodItemViewController, router: MangamentFoodItemRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
    
    func makePopToViewController() {
        router?.makePopToviewController()
    }
}
extension MangamentFoodItemViewModel {
    func getListFood() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListFood(Idcategoryfood: idcategory.value))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
    
}
