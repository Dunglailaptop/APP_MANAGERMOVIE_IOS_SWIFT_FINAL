//
//  ListinfoCinemaViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 26/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift

class ListinfoCinemaViewModel: BaseViewModel {
    
    private(set) weak var view: ListInfoCinemaViewController?
    private var router: ListInfoCinemaRouter?
   
    public var dataciema: BehaviorRelay<Cinema> = BehaviorRelay(value: Cinema())
    public var idcinema: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    func bind(view: ListInfoCinemaViewController, router: ListInfoCinemaRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makePopToViewController() {
        router?.makePopToViewController()
    }
 
    
 

}
extension ListinfoCinemaViewModel {
    func getDetailCinema() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailInfoCinema(idcinema: idcinema.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
            
    }
    
}
