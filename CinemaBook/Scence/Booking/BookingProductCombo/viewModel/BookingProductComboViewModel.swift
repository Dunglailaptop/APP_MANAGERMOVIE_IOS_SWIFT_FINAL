//
//  BookingProductComboViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 10/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BookingProductComboViewModel: BaseViewModel {
    private(set) weak var view: BookingProductComboViewController?
    private var router: BookingProductComboRouter?
    
    var idmovie: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var dataArray: BehaviorRelay<[FoodCombo]> = BehaviorRelay(value: [])
    var dataArrayVoucher:BehaviorRelay<[voucher]> = BehaviorRelay(value: [])
    var dataCombo:BehaviorRelay<[FoodCombo]> = BehaviorRelay(value: [])
    func bind(view: BookingProductComboViewController,router: BookingProductComboRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
    func makePopToViewPayment(dataChair:[chair],infoInterestMovie:InfoInterestMovie,datafoodcombo:[FoodCombo]) {
        router?.makeToPaymentViewController(dataChairs: dataChair, infoInterestMovie: infoInterestMovie, dataFoodCombo: datafoodcombo)
    }
    
}
extension BookingProductComboViewModel {
    func getListFoodCombo() -> Observable<APIResponse> {
            return appServiceProvider.rx.request(.getListFoodCombo)
                     .filterSuccessfulStatusCodes()
                     .mapJSON().asObservable()
                     .showAPIErrorToast()
                     .mapObject(type: APIResponse.self)
             }
   
}
