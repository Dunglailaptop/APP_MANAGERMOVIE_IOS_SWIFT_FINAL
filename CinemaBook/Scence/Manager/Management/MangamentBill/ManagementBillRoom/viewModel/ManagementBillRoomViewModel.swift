//
//  ManagementBillRoomViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 04/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class ManagementBillRoomViewModel: BaseViewModel{
    private(set) weak var view: ManagementBillRoomViewController?
    private var router: ManagementBillRoomRouter?
    
    public var dataArray: BehaviorRelay<[Room]> = BehaviorRelay(value: [])
    public var dataArraySearch: BehaviorRelay<[Room]> = BehaviorRelay(value: [])
    
    func bind(view: ManagementBillRoomViewController, router: ManagementBillRoomRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makeToInterestMovie(idroom:Int) {
        router?.navigationmaketoInterest(idroom: idroom)
    }
    
}
extension ManagementBillRoomViewModel {
    func getListRoom() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListRoom(idcinema: ManageCacheObject.getCurrentCinema().idcinema))
                     .filterSuccessfulStatusCodes()
                     .mapJSON().asObservable()
                     .showAPIErrorToast()
                     .mapObject(type: APIResponse.self)
             }
}
