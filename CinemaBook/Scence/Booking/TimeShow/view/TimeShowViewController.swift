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

    @IBOutlet weak var calender: FSCalendar!
    var viewModel = TimeShowViewModel()
  var router = TimeShowRouter()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
          register()
        bindingtableviewcell()
   getListInterestCinema()
        calender.scope = .week
        calender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calender.topAnchor.constraint(equalTo: calender.topAnchor),
            calender.leadingAnchor.constraint(equalTo: calender.leadingAnchor),
            calender.trailingAnchor.constraint(equalTo: calender.trailingAnchor),
            calender.bottomAnchor.constraint(equalTo: calender.bottomAnchor)
        ])
        FSCalendar.appearance().rowHeight = 100 // Điều chỉnh chiều cao của
        
        calender.backgroundColor = .darkGray
    // Điều chỉnh chiều cao của phần header (tháng và năm)
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
          
    }

    
    @IBAction func btn_popToViewController(_ sender: Any) {
        viewModel.navigationPopToViewController()
    }
    
}
