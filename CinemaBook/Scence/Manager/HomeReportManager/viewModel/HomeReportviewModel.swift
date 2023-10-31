//
//  HomeReportviewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeReportviewModel: BaseViewModel{
    private(set) weak var view: HomeReportViewController?
    private var router: HomeReportRouter?
    
    public var data: BehaviorRelay<(date_string:String,report_type:Int)> = BehaviorRelay(value: (date_string:Utils.getCurrentDateStringformatMysqlyymmdd(),report_type:1))
    
    public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2])
    public var dataTicketReport: BehaviorRelay<ReportTotalAll> = BehaviorRelay(value: ReportTotalAll())
    func bind(view: HomeReportViewController, router: HomeReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
 
}

extension HomeReportviewModel {
    func getReportTicket() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.GetReportTicket(report_type: data.value.report_type))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}


