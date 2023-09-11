//
//  ManagementEmployeeViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/11/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementEmployeeViewController: BaseViewController {

    var viewModel = ManagementEmployeeViewModel()
    var router = ManagementEmployeeRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        // Do any additional setup after loading the view.
    }


}
