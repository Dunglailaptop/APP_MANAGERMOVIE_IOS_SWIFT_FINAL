//
//  ReportTicketALLViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 31/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ReportTicketALLViewModel: BaseViewModel{
    private(set) weak var view: ReportTicketALLViewController?
    private var router: ReportTicketALLRouter?
   
    public var data: BehaviorRelay<(date_string:String,report_type:Int)> = BehaviorRelay(value: (date_string:Utils.getCurrentDateStringformatMysqlyymmdd(),report_type:1))
    
    public var dataTicketReport: BehaviorRelay<ReportTotalAll> = BehaviorRelay(value: ReportTotalAll())
    
    func bind(view: ReportTicketALLViewController, router: ReportTicketALLRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makePopToViewController() {
        router?.makeToPopViewController()
    }
 
}
extension ReportTicketALLViewModel {
    func getReportTicket() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.GetReportTicket(report_type: data.value.report_type))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}
