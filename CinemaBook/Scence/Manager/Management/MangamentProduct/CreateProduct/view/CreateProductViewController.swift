//
//  CreateProductViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class CreateProductViewController: UIViewController {

    var viewModel = CreateProductViewModel()
    var router = CreateProductRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view:self,router:router)

        // Do any additional setup after loading the view.
    }


 

}
