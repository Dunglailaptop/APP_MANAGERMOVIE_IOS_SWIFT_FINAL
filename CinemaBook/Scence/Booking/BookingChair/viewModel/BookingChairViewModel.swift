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
    
    public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96])
    public var listtable: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1])
    
    func bind(view: BookingChairViewController, router: BookingChairRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
    
}
