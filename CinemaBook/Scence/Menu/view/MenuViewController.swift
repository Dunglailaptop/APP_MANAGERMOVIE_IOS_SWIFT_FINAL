//
//  MenuViewController.swift
//  CinemaBook
//
//  Created by dungtien on 7/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {
    
    var viewModel = MenuViewModel()
    var router  = MenuRouter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind(view: self, router: router)
        self.setupNavigationBar()
        // Do any additional setup after loading the view.
    }
   
}
