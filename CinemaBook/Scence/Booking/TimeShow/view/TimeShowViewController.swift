//
//  TimeShowViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/27/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import QVRWeekView
import FSCalendar

class TimeShowViewController: BaseViewController {

  var viewModel = TimeShowViewModel()
  var router = TimeShowRouter()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
          register()
        bindingtableviewcell()
      
    }
    

    
    @IBAction func btn_popToViewController(_ sender: Any) {
        viewModel.navigationPopToViewController()
    }
    
}
