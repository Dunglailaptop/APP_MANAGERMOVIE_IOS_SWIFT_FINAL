//
//  DetailMovieviewModel.swift
//  CinemaBook
//
//  Created by dungtien on 8/14/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailMovieviewModel {
    private(set) weak var view: DetailMovieViewController?
    private var router: DetailMovieRouter?
    
    var idmovie: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var data: BehaviorRelay<Movie> = BehaviorRelay(value: Movie())
    
    
    func bind(view: DetailMovieViewController,router: DetailMovieRouter){
        self.view = view
        self.router = router
        self.router?.setSourceview(view)
    }
    
    func makePopToViewController(){
        self.router?.makePopToViewController()
    }
    
    func makeToBookingChairViewController(){
        router?.navigationMakeToBookingChairViewController()
    }
    
    
    
}

extension DetailMovieviewModel {
    func getDetailMovie() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.MovieDetail(idmovie: idmovie.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
