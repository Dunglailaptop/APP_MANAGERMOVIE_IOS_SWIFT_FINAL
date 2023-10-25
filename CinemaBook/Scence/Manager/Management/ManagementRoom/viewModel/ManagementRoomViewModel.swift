//
//  ManagementRoomViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ManagementRoomViewModel: BaseViewModel {
    private(set) weak var view: ManagementRoomViewController?
    private var router: ManagementRoomRouter?
    public var dataArrayChair: BehaviorRelay<[chair]> = BehaviorRelay(value: [])
    public var dataArrayRoom: BehaviorRelay<[Room]> = BehaviorRelay(value: [])
    public var dataArrayRoomsearch: BehaviorRelay<[Room]> = BehaviorRelay(value: [])
    public var dataArrayCategoryChair: BehaviorRelay<[CategoryChair]> = BehaviorRelay(value: [])
    public var dataArrayCategoryChairsearch: BehaviorRelay<[CategoryChair]> = BehaviorRelay(value: [])
    public var dataChoose: BehaviorRelay<(Idcinema:Int,Idroom:Int,Idcategory:Int)> = BehaviorRelay(value: (Idcinema: ManageCacheObject.getCurrentCinema().idcinema,Idroom:1,Idcategory:0))
    public var dataCategoryChair = BehaviorRelay<CategoryChair>(value: CategoryChair())
   
    func bind(view: ManagementRoomViewController, router: ManagementRoomRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
    
    func makePopToViewController() {
        router?.navigationPopToViewController()
    }
    
    func makeCreateRoomViewController() {
        router?.navigationToCreatRoomViewController()
    }
    
    func makeToManagementDetailViewController(room:Room) {
        router?.navigationToManagementDetailRoom(room: room)
    }
}

extension ManagementRoomViewModel {
    func getListRoom() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListRoom(idcinema: dataChoose.value.Idcinema))
                     .filterSuccessfulStatusCodes()
                     .mapJSON().asObservable()
                     .showAPIErrorToast()
                     .mapObject(type: APIResponse.self)
             }
    func getListCategoryChair() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListCategoryChair)
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
    func getListchairRoom() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListChairRoom(Idroom: dataChoose.value.Idroom))
                     .filterSuccessfulStatusCodes()
                     .mapJSON().asObservable()
                     .showAPIErrorToast()
                     .mapObject(type: APIResponse.self)
             }
    
    func createCategoryChair() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.CreateCategoryChair(categoryinfo: dataCategoryChair.value))
                     .filterSuccessfulStatusCodes()
                     .mapJSON().asObservable()
                     .showAPIErrorToast()
                     .mapObject(type: APIResponse.self)
             }
    func getDetailInfoCategoryChair() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailInfoCategoryChair(idcategory: dataChoose.value.Idcategory))
                     .filterSuccessfulStatusCodes()
                     .mapJSON().asObservable()
                     .showAPIErrorToast()
                     .mapObject(type: APIResponse.self)
             }
    func updateinfocategorychairwithinfo() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.updateInfoCategoryChair(infocategory: dataCategoryChair.value ))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}
