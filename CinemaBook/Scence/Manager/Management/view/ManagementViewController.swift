//
//  ManagementViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/10/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementViewController: BaseViewController {

    var viewModel = ManagementViewModel()
    var router = ManagementRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
    }


    @IBAction func btn_makeToManageEmployeeViewContrller(_ sender: Any) {
        viewModel.navigationToManagementEmployee()
    }
   
    @IBAction func btn_makeToManagemnetMovieViewController(_ sender: Any) {
        viewModel.navigationToManagementMovie()
    }
    
    @IBAction func btn_makeToManagementInterestMovie(_ sender: Any) {
        viewModel.navigationToManagementMovieInterest()
    }
    
 
    @IBAction func btn_makeToManagementRoomViewController(_ sender: Any) {
        viewModel.navigationToManagementRoomViewController()
    }
}
