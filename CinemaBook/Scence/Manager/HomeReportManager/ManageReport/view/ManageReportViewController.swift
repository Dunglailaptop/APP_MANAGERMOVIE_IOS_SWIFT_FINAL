//
//  ManageReportViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 29/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManageReportViewController: UIViewController {

    var viewModel = ManageReportViewModel()
    var router = ManageReportRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
    }


    @IBAction func btn_managementReportTicketall(_ sender: Any) {
        viewModel.makeToReportTicketViewController()
    }
    
    @IBAction func btn_makeToReportMovie(_ sender: Any) {
        viewModel.makeToReportMovieViewController()
    }
    @IBAction func btn_makeToReportFood(_ sender: Any) {
        viewModel.makeToReportFoodViewController()
    }
}
