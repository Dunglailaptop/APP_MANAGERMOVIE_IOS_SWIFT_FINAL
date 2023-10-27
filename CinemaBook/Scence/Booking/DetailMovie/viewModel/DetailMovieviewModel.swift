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
    private(set) weak var view: DetailMovieInfoViewController?
    private var router: DetailMovieRouter?
    
    var idmovie: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var dataArray: BehaviorRelay<Movie> = BehaviorRelay(value: Movie())
    var dataArrayVoucher:BehaviorRelay<[voucher]> = BehaviorRelay(value: [])
    
    func bind(view: DetailMovieInfoViewController,router: DetailMovieRouter){
        self.view = view
        self.router = router
        self.router?.setSourceview(view)
    }
    
    func makePopToViewController(){
        self.router?.makePopToViewController()
    }
    
    func makeToBookingChairViewController(idmovie:Int,namemovie:String){
        router?.navigationMakeToBookingChairViewController(idmovie:idmovie,namemovie: namemovie)
    }
    
    func makeToVideoYoutuebViewController(videoId:String) {
        router?.navigationMakeVideoYoutubeViewController(videoid:videoId)
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
    func getListVoucher() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListVoucher)
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
