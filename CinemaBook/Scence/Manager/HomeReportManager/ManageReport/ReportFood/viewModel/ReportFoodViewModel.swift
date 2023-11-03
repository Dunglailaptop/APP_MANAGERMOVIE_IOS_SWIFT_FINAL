//
//  ReportFoodViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 03/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class ReportFoodViewModel: BaseViewModel{
    private(set) weak var view: ReportFoodViewController?
    private var router: ReportFoodRouter?
   
    public var data: BehaviorRelay<(date_string:String,report_type:Int)> = BehaviorRelay(value: (date_string:Utils.getCurrentDateStringformatMysqlyymmdd(),report_type:1))
    
    public var datafoodReport: BehaviorRelay<[ReportFood]> = BehaviorRelay(value: [])
    
    
    
    func bind(view: ReportFoodViewController, router: ReportFoodRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makePopToViewController(){
        router?.makePopToViewController()
    }
    
  
    
 
}
extension ReportFoodViewModel {
    func getReportfood() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.reportFood(report_type: data.value.report_type))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}
