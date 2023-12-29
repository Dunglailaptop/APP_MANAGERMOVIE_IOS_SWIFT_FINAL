//
//  NewFeedViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/10/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class NewFeedViewModel: BaseViewModel
{
    private(set) weak var view: NewFeedViewController?
//    private var router: MovieRouter?
    
    var dataArray: BehaviorRelay<[Trailler]> = BehaviorRelay(value: [])
    var dataArraySearch: BehaviorRelay<[Trailler]> = BehaviorRelay(value: [])
//    func bind(view: MovieViewController, router: MovieRouter)
//    {
//        self.view = view
//        self.router =  router
//        self.router?.setSourceView(self.view!)
//    }
    func clearData() {
        dataArray.accept([])
        dataArraySearch.accept([])
    }
 
   
}
extension NewFeedViewModel {
    func getListTraillerShowBanner() -> Observable<APIResponse> {
    return appServiceProvider.rx.request(.getListTrailler)
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
