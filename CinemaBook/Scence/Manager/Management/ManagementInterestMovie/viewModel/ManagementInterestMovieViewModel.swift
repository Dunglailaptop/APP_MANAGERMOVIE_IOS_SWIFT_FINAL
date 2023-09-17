//
//  ManagementInterestMovieViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/15/23.
//  Copyright © 2023 dungtien. All rights reserved.
//



import UIKit
import RxSwift
import RxCocoa

class ManagementInterestMovieViewModel: BaseViewModel{
    private(set) weak var view: ManagementInterestMovieViewController?
    private var router: ManagementInterestMovieRouter?
    
    public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1])
    
    public var dataArrayRoom: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,3,4,5,6,7,8,9])
    
    public var dataArrayday: BehaviorRelay<[Date]> = BehaviorRelay(value: [])
    
    public var dataDay: BehaviorRelay<(DateForm:String,DateTo:String)> = BehaviorRelay(value: (DateForm: Utils.getCurrentDateStringformatMysql(),DateTo:Utils.getCurrentDateStringformatMysql()))
    
    func bind(view: ManagementInterestMovieViewController, router: ManagementInterestMovieRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makePopToViewController() {
        router?.navigationPopToViewController()
    }
  
}
