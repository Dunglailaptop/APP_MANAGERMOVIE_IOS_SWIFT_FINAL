//
//  ManagementEmployeeViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/11/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementEmployeeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = ManagementEmployeeViewModel()
    var router = ManagementEmployeeRouter()
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        register()
        bindingtablecell()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getlistEmployee()
    }
    @IBAction func btn_makeToAccountinfoViewController(_ sender: Any) {
        viewModel.makeToAccountinfo(iduser: 0)
    }
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopTovViewController()
    }
}
