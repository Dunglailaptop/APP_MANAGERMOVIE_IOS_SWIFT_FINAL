//
//  DetailProductViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 12/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailProductViewModel: BaseViewModel {
    private(set) weak var view: DetailProductComboViewController?
    private var router: DetailProductRouter?
    public var DetaillistFoodCombo:BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2])
 
    //data food in combo
    public var dataArrayFoodincombo: BehaviorRelay<[Food]> = BehaviorRelay(value: [])
    //data food
    public var dataArrayfood: BehaviorRelay<[Food]> = BehaviorRelay(value: [])
    public var dataArrayFoodWater: BehaviorRelay<[Food]> = BehaviorRelay(value: [])
    public var dataDetailFoodCombo: BehaviorRelay<FoodCombo> = BehaviorRelay(value: FoodCombo())
    public var dataAllFood: BehaviorRelay<[Food]> = BehaviorRelay(value: [])
    
    func bind(view: DetailProductComboViewController,router: DetailProductRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopToViewOrderProduct() {
        router?.makePopToViewController()
    }
    func makeToCartViewController() {
        router?.makeToCartViewController()
    }
    
}
extension DetailProductViewModel {
    func getListFood() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListFood(Idcategoryfood: 2))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
    func getListFoodwater() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListFood(Idcategoryfood: 1))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
   
}
