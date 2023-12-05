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
    public var pagition: BehaviorRelay<(idroom:Int,idcinema:Int,idinterest:Int,idmovie:Int)> = BehaviorRelay(value: (idroom:1,idcinema:1,idinterest:3,idmovie:0))
    public var dataArray: BehaviorRelay<[chair]> = BehaviorRelay(value: [])
    public var listtable: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2])
        public var ChairCategory: BehaviorRelay<[CategoryChair]> = BehaviorRelay(value: [])
    public var infoInterestMovie: BehaviorRelay<InfoInterestMovie> = BehaviorRelay(value: InfoInterestMovie())
    public var dataArrayBillListWithRoom: BehaviorRelay<[billinfowithroom]> = BehaviorRelay(value: [])
    func bind(view: BookingChairViewController, router: BookingChairRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
    
    func makeToBookingProductComboViewController(dataInfoMovie:InfoInterestMovie,datachairs:[chair]) {
        router?.makeToBookingProductComboViewController(dataInfoMovieS:dataInfoMovie,dataChairs:datachairs)
    }
    
    func makeToDetailBillViewController(idbill:Int) {
        router?.makeToDetailBillViewController(idbill: idbill)
    }
    
}
extension BookingChairViewModel{
    func getlistbillroom() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getlistbillwithroom(idroom: pagition.value.idroom, idinterest: pagition.value.idinterest))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
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
    func getinfoInterestMovie() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getInfoInterestMovie(idmovie: pagition.value.idmovie, idcinema: pagition.value.idcinema, idroom: pagition.value.idroom, idinterest: pagition.value.idinterest))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
    func getListCategoryChairRoom() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.GetListCategoryChairInRoom(idroom: pagition.value.idroom))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}
