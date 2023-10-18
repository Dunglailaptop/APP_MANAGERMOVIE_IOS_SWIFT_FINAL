//
//  ManagementBillFoodComboViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 17/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class ManagementBillFoodComboViewModel: BaseViewModel {
    
    private(set) weak var view: ManagementBillFoodComboViewController?
    private var router: ManagementBillFoodComboRouter?
    
    public var dataArray: BehaviorRelay<[PaymentInfoBillFoodCombo]> = BehaviorRelay(value: [])
    
    func bind(view: ManagementBillFoodComboViewController, router: ManagementBillFoodComboRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
 
    
    
}
extension ManagementBillFoodComboViewModel {
    func getListAllBillFoodCombo() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListAllBillFoodCombo(idcinema: ManageCacheObject.getCurrentCinema().idcinema, status: 0))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }

}
