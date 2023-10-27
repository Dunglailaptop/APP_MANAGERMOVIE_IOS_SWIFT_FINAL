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
    public var allvalue: BehaviorRelay<(datefrom:String,dateto:String,status:Int)> = BehaviorRelay(value: (datefrom: Utils.getCurrentDateStringformatMysqlyymmdd(),dateto: Utils.getCurrentDateStringformatMysqlyymmdd(),status:0))
    func bind(view: ManagementBillFoodComboViewController, router: ManagementBillFoodComboRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    func makeToManageDetailViewController(Paymentinfobill: PaymentInfoBillFoodCombo) {
        router?.navigationToDetailProductFoodComboBill(PaymentBillfoodcombo: Paymentinfobill)
    }
    
    
}
extension ManagementBillFoodComboViewModel {
    func getListAllBillFoodCombo() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListAllBillFoodCombo(idcinema: ManageCacheObject.getCurrentCinema().idcinema, status: allvalue.value.status,datefrom: allvalue.value.datefrom ,dateto: allvalue.value.dateto))
                       .filterSuccessfulStatusCodes()
                       .mapJSON().asObservable()
                       .showAPIErrorToast()
                       .mapObject(type: APIResponse.self)
               }

}
