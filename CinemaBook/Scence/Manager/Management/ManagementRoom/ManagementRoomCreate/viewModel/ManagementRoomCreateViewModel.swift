//
//  ManagementRoomCreateViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/25/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxSwift
import  RxCocoa

class ManagementRoomCreateViewModel: BaseViewModel {
    private(set) weak var view: ManagementRoomCreateViewController?
    private var router: MangementRoomCreateRouter?
    
    public var data: BehaviorRelay<Room> = BehaviorRelay(value: Room())
    
    func bind(view: ManagementRoomCreateViewController, router: MangementRoomCreateRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
    
    func makePopToViewController() {
        router?.navigationPopToViewController()
    }
}
extension ManagementRoomCreateViewModel{
 
    func CreateRoom() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postCreateChairInRoom(idcinema: data.value.idcinema, nameroom: data.value.nameroom, numberChair: data.value.chairinrow, allschair: data.value.allchair))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }
}
