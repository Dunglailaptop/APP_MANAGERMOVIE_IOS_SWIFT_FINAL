//
//  MovieViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift

class MovieViewModel: BaseViewModel
{
    private(set) weak var view: MovieViewController?
    private var router: MovieRouter?
    
    var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,3,4,5,6,7,8,9,10])
    
    func bind(view: MovieViewController, router: MovieRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
 
   
}
