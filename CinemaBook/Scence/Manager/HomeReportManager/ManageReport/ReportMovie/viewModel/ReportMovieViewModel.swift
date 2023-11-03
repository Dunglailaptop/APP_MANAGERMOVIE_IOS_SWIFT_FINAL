//
//  ReportMovie.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 03/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ReportMovieViewModel: BaseViewModel{
    private(set) weak var view: ReportMovieViewController?
    private var router: ReportMovieRouter?
   
    public var dataMovieReport: BehaviorRelay<[ReportMovie]> = BehaviorRelay(value: [])
    
    
    public var data: BehaviorRelay<(date_string:String,report_type:Int)> = BehaviorRelay(value: (date_string:Utils.getCurrentDateStringformatMysqlyymmdd(),report_type:1))
    
    func bind(view: ReportMovieViewController, router: ReportMovieRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
 
}
extension ReportMovieViewModel {
    func getReportMovie() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.ReportMovie(report_type: data.value.report_type))
                        .filterSuccessfulStatusCodes()
                        .mapJSON().asObservable()
                        .showAPIErrorToast()
                        .mapObject(type: APIResponse.self)
                }
}
