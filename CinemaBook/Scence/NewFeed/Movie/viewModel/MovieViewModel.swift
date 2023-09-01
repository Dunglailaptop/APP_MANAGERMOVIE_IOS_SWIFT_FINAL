//
//  MovieViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit

class MovieViewModel: BaseViewModel
{
    private(set) weak var view: MovieViewController?
    private var router: MovieRouter?
    
    
    
    func bind(view: MovieViewController, router: MovieRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
 
   
}
