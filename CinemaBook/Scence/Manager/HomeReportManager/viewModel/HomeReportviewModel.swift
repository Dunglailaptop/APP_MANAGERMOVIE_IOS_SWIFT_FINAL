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
    
    public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,3])
    public var dataTicketReport: BehaviorRelay<ReportTotalAll> = BehaviorRelay(value: ReportTotalAll())
    public var dataMovieReport: BehaviorRelay<[ReportMovie]> = BehaviorRelay(value: [])
    public var datafoodReport: BehaviorRelay<[ReportFood]> = BehaviorRelay(value: [])
    func bind(view: HomeReportViewController, router: HomeReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makeToReportTicketViewController() {
        router?.maketoManagementReportTicketAll()
    }
    
    func makeToReportMovieViewController() {
        router?.makeToReportMovie()
    }
    func makeToReportFoodViewController() {
        router?.makeToReportfood()
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
    func getReportMovie() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.ReportMovie(report_type: data.value.report_type))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
    func getReportfood() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.reportFood(report_type: data.value.report_type))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}


