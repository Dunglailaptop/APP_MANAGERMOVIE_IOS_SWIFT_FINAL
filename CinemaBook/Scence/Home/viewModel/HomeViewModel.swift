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

class HomeViewModel: BaseViewModel {
    
    private(set) weak var view: HomeViewController?
//    private var router: AccountRouter?
//
//    func bind(view: AccountViewController, router: AccountRouter){
//           self.view = view
//           self.router = router
//           self.router?.setSourceView(self.view)
//       }
    
    func cleardata() {
        dataArrayMovie.accept([])
    }
    
    var listtablecell:BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1])
    var dataArrayMovie:BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    var dataArrayTrailler:BehaviorRelay<[Trailler]> = BehaviorRelay(value: [])
    var dataArrayVoucher:BehaviorRelay<[voucher]> = BehaviorRelay(value: [])
    var dataArrayProduct:BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2])
    var pagigation: BehaviorRelay<(page:Int,limit:Int,status:Int)> = BehaviorRelay(value:(page:0,limit:20,status:1))
}
extension HomeViewModel {
    func getListMovieShowBanner() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.Moive(page: pagigation.value.page, limit: pagigation.value.limit, status: pagigation.value.status))
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
}
