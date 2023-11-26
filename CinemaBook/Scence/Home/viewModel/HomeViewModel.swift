//
//  HomeViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 7/15/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift
import RxRelay

class HomeViewModel: BaseViewModel {
    
    private(set) weak var view: HomeViewController?
    private var router: HomeRouter?

    func bind(view: HomeViewController, router: HomeRouter){
           self.view = view
           self.router = router
           self.router?.setSourceView(self.view)
       }
    
    func maketoDetailViewContrller(idmovie:Int) {
        router?.navigationToDetailViewController(idmovie: idmovie)
    }
    
    func makeToStoreViewController() {
        router?.navigationToStoreProductViewController()
    }
    
    func makeToListInfocinema() {
        router?.navigationToListInfoCinema()
    }
    
    func cleardata() {
        dataArrayMovie.accept([])
    }
     var listcell:BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2])
    var listtablecell:BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,3,4])
    var dataArrayMovie:BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    var dataArrayTrailler:BehaviorRelay<[Trailler]> = BehaviorRelay(value: [])
    var dataArrayVoucher:BehaviorRelay<[voucher]> = BehaviorRelay(value: [])
    var dataArrayProduct:BehaviorRelay<[Cinema]> = BehaviorRelay(value: [])
    var pagigation: BehaviorRelay<(page:Int,limit:Int,status:Int,dateFrom:String,dateTo:String)> = BehaviorRelay(value:(page:0,limit:20,status:1,dateFrom:"",dateTo:""))
    
    
}
extension HomeViewModel {
    func getListMovieShowBanner() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.Moive(page: pagigation.value.page, limit: pagigation.value.limit, status: pagigation.value.status,Idcategory: 0,dateFrom: pagigation.value.dateFrom,dateTo: pagigation.value.dateTo))
                .filterSuccessfulStatusCodes()
                .mapJSON().asObservable()
                .showAPIErrorToast()
                .mapObject(type: APIResponse.self)
        }
    func getListVoucherShowBanner() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListVoucher)
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
    func getListTraillerShowBanner() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListTrailler)
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
    func getListCinema() -> Observable<APIResponse> {
           return appServiceProvider.rx.request(.getListCinema)
                      .filterSuccessfulStatusCodes()
                      .mapJSON().asObservable()
                      .showAPIErrorToast()
                      .mapObject(type: APIResponse.self)
              }
}
