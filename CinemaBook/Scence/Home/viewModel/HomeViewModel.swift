//
//  HomeViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 7/15/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift

class HomeViewModel {
    var listtablecell:BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1])
    
}
