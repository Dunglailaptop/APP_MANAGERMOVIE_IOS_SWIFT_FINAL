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
    public var dataArraySearch: BehaviorRelay<[Food]> = BehaviorRelay(value: [])
    public var datafood: BehaviorRelay<Food> = BehaviorRelay(value: Food())
    public var datacategoryfood: BehaviorRelay<[CategoryFood]> = BehaviorRelay(value: [])
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
    func getListCategoryFood() -> Observable<APIResponse> {
              return appServiceProvider.rx.request(.getListCategoryFood)
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
    func createFood() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.createFoodNew(food: datafood.value))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
    func getDetailFood() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailfood(idfood: datafood.value.idfood))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
    func updateinfofood() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.updateinfodetailfood(food: datafood.value))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
    
}
