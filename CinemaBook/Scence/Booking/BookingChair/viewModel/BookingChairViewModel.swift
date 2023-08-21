//
//  BookingChairViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import JonAlert


class  BookingChairViewModel
{
    private(set) weak var view: BookingChairViewController?
    private var router: BookingChairRouter?
    
    public var dataArray: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    
    func bind(view: BookingChairViewController, router: BookingChairRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
  
    
}
