//
//  StoreViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class StoreViewModel: BaseViewModel {
    private(set) weak var view: StoreViewController?
    private var router: StoreRouter?
    
    
    public var dataArrayFoodCombo: BehaviorRelay<[Int]> = BehaviorRelay(value : [1,2,3])
    
    func bind(view: StoreViewController,router: StoreRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceview(view)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
    
    func makeToDetailProductViewController() {
        router?.makeToProductComboViewController()
    }
    
    func makePopStoreViewController() {
        router?.makeToPopStoreViewController()
    }
    
}
extension StoreViewModel {
    func getListCinema() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListCinema)
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}

