//
//  TimeMovieShowNow.swift
//  CinemaBook
//
//  Created by dungtien on 8/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JonAlert


class ListMovieShowNowViewModel: BaseViewModel
{
    private(set) weak var view: ListMovieShowNowViewController?
    private var router: ListMovieShowNowRouter?
    
    public var dataArray: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    
    var allvalue: BehaviorRelay<(page:Int,limit:Int,status:Int)> = BehaviorRelay(value: (page:0, limit:20,status:1))
    
    func bind(view: ListMovieShowNowViewController, router: ListMovieShowNowRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
    func makeToDetailMovieViewController(id:Int){
        router?.navigationMakeToDetailMovieViewController(id:id)
    }
    
   
}

extension ListMovieShowNowViewModel {
    func getListMovieShow() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.Moive(page: allvalue.value.page, limit: allvalue.value.limit,status: allvalue.value.status))
             .filterSuccessfulStatusCodes()
             .mapJSON().asObservable()
             .showAPIErrorToast()
             .mapObject(type: APIResponse.self)
     }
}