//
//  MangamentProductViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MangamentProductViewModel: BaseViewModel {
    private(set) weak var view: MangamentProductViewController?
    private var router: MangamentProductRouter?
    
    public var dataArray:BehaviorRelay<[CategoryFood]> = BehaviorRelay(value: [])
    
    func bind(view: MangamentProductViewController, router: MangamentProductRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
    func makeToCreateViewController() {
        router?.navigationtocreateproduct()
    }
    func makePopToViewController() {
        router?.navigationPopToViewController()
    }
}

extension MangamentProductViewModel {
    func getListCategoryFood() -> Observable<APIResponse> {
              return appServiceProvider.rx.request(.getListCategoryFood)
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
}
