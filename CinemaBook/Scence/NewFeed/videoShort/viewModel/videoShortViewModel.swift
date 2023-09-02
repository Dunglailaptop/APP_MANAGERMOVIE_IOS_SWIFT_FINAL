//
//  videoShortViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class videoShortViewModel: BaseViewModel
{
    private(set) weak var view: videoShortViewController?
    private var router: videoShortRouter?
    
    var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30])
    
    func bind(view: videoShortViewController, router: videoShortRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
 
   
}
