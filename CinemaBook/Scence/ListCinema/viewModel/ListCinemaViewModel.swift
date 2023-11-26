//
//  ListCinemaViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 26/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift

class ListCinemaViewModel: BaseViewModel {
    
    private(set) weak var view: ListCinemaViewController?
    private var router: ListCinemaRouter?
   
    public var dataCinema: BehaviorRelay<[Cinema]> = BehaviorRelay(value: [])
    func bind(view: ListCinemaViewController, router: ListCinemaRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makePopToViewController() {
        router?.makePopToViewController()
    }
 
    func makeToDetailCinemaViewController(idcinema:Int) {
        router?.makeToDetailCinemaViewController(idcinema: idcinema)
    }
 

}
extension ListCinemaViewModel {
    func getlistCinema() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListCinema)
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
            
    }
    
}
