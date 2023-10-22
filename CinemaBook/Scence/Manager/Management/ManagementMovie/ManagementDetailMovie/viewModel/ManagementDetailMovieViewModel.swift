//
//  ManagementDetailMovieViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 21/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ManagementDetailMovieViewModel: BaseViewModel{
    private(set) weak var view: ManagementDetailMovieViewController?
    private var router: ManagemetDetailMovieRouter?
    public var dataArrayNation: BehaviorRelay<[Nation]> = BehaviorRelay(value: [])
    public var dataArrayMovie: BehaviorRelay<[CategoryMovie]> = BehaviorRelay(value: [])
    public var pagigation:BehaviorRelay<(page:Int,limit:Int,status:Int)> = BehaviorRelay(value: (page:0,limit:20,status:1))
    public var valueMovie:BehaviorRelay<Movie> = BehaviorRelay(value: Movie())
    func bind(view: ManagementDetailMovieViewController, router: ManagemetDetailMovieRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makePopTovViewController(){
        router?.navigationPopViewController()
    }
    func check() {
        dLog(valueMovie.value)
    }
    
}
extension ManagementDetailMovieViewModel {
    func getListNation() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListNation)
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
    }
    func getListCategortMovie() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListCategoryMovie)
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
    }
    
    func createNewMovie() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.CreateMovie(movievalue: valueMovie.value))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
    }
    
    func updateMovie() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.UpdateMovie(movievalue: valueMovie.value))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
    }
    
    func getDetailMovie() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.MovieDetail(idmovie: valueMovie.value.movieID))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
}
