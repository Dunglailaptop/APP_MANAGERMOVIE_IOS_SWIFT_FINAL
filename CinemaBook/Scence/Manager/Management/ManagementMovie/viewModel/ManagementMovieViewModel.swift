//
//  ManagementMovieViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/14/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ManagementMovieViewModel: BaseViewModel{
    private(set) weak var view: ManagementMovieViewController?
    private var router: ManagementMovieRouter?
    
    public var dataArray: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    public var pagigation:BehaviorRelay<(page:Int,limit:Int,status:Int,Idcategory:Int,dateFrom:String,dateTo:String)> = BehaviorRelay(value: (page:0,limit:20,status:1,Idcategory:0,dateFrom:"",dateTo:""))
    
    func bind(view: ManagementMovieViewController, router: ManagementMovieRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makePopTovViewController(){
        router?.navigationPopViewController()
    }
    
    func makeToManagementDetailViewController() {
        router?.navigationToManagementDetailViewController()
    }
    
}
extension ManagementMovieViewModel {
    func getListMovie() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.Moive(page: pagigation.value.page, limit: pagigation.value.limit, status: pagigation.value.status,Idcategory: pagigation.value.Idcategory,dateFrom: pagigation.value.dateFrom,dateTo: pagigation.value.dateTo))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
    }
}
