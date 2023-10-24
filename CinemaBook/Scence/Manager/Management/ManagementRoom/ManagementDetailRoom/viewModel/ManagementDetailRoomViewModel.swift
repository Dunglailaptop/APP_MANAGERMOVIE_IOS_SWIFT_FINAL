//
//  ManagementDetailRoomViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 23/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ManagementDetailRoomViewModel: BaseViewModel {
    private(set) weak var view: ManagementDetailRoomViewController?
    private var router: ManagementDetailRoomRouter?
    public var dataArrayCategoryChair: BehaviorRelay<[CategoryChair]> = BehaviorRelay(value: [])
    public var dataArrayChairChoose: BehaviorRelay<[chair]> = BehaviorRelay(value: [])
    public var idroom: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    func bind(view: ManagementDetailRoomViewController, router: ManagementDetailRoomRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
    
    func makePopToViewController() {
        router?.navigationPopToViewController()
    }
    
 
}
extension ManagementDetailRoomViewModel {
    func getListCategoryChair() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListCategoryChair)
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}
