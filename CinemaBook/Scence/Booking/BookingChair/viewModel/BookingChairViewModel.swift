//
//  BookingChairViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import JonAlert


class  BookingChairViewModel: BaseViewModel
{
    private(set) weak var view: BookingChairViewController?
    private var router: BookingChairRouter?
    public var pagition: BehaviorRelay<(idroom:Int,idcinema:Int,idinterest:Int)> = BehaviorRelay(value: (idroom:1,idcinema:1,idinterest:3))
    public var dataArray: BehaviorRelay<[chair]> = BehaviorRelay(value: [])
    public var listtable: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2])
        public var ChairCategory: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2])
    
    func bind(view: BookingChairViewController, router: BookingChairRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
    
}
extension BookingChairViewModel{
    func getListchair() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListChair(idroom: pagition.value.idroom, Idcinema: pagition.value.idcinema, idinterest: pagition.value.idinterest))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
         }
    func getListchairRoom() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListChairRoom(Idroom: pagition.value.idroom))
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
}
