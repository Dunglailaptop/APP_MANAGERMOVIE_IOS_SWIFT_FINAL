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
    
}
