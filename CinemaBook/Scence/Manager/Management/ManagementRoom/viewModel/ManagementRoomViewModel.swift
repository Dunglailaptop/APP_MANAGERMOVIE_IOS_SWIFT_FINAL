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
  
    public var dataArrayRoom: BehaviorRelay<[Room]> = BehaviorRelay(value: [])
    public var dataArrayCategoryChair: BehaviorRelay<[CategoryChair]> = BehaviorRelay(value: [])
    public var dataChoose: BehaviorRelay<(Idcinema:Int,Idroom:Int)> = BehaviorRelay(value: (Idcinema: ManageCacheObject.getCurrentCinema().idcinema,Idroom:1))
    
    func bind(view: ManagementRoomViewController, router: ManagementRoomRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
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
        return appServiceProvider.rx.request(.getListCategoryChair(Idroom: dataChoose.value.Idroom))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}
