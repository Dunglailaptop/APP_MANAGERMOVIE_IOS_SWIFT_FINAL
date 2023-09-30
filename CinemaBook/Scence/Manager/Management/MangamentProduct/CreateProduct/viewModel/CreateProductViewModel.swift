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
    public var Idcategory: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var dataArray:BehaviorRelay<[Food]> = BehaviorRelay(value: [])
    public var dataMap: BehaviorRelay<FoodCombo> = BehaviorRelay(value: FoodCombo())
    func bind(view: CreateProductViewController, router: CreateProductRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
    
    func makePopToViewController() {
        router?.makePopToviewController()
    }
}
extension CreateProductViewModel {
    func getListFood() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListFood(Idcategoryfood: Idcategory.value))
                     .filterSuccessfulStatusCodes()
                     .mapJSON().asObservable()
                     .showAPIErrorToast()
                     .mapObject(type: APIResponse.self)
             }
  
    func createComboFood() -> Observable<APIResponse> {
        var data:[Food] = []
        for datas in dataArray.value.filter{$0.isSelected == ACTIVE} {
            data.append(datas)
        }
        dLog(dataMap.value.picture)
        return appServiceProvider.rx.request(.createFoodCombo(nametittle: dataMap.value.nametittle, discription: dataMap.value.descriptions, priceCombo:  dataMap.value.priceCombo, picture: dataMap.value.picture, foodCreates: data))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
}
