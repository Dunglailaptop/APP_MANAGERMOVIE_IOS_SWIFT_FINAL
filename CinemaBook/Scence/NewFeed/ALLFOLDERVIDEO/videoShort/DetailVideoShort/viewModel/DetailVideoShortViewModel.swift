//
//  DetailVideoShortViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailVideoShortViewModel: BaseViewModel
{
    private(set) weak var view: DetailVideoShortViewController?
    private var router: DetailVideoShortRouter?
    
    var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,3,4,5,6,7,8,9,10])
    
    let rxbag = DisposeBag()
    
    func bind(view: DetailVideoShortViewController, router: DetailVideoShortRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
 
   
}
