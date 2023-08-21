//
//  TicketViewController.swift
//  CinemaBook
//
//  Created by dungtien on 7/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class TicketViewController: BaseViewController {
    
    var viewModel = TicketViewModel()
    var router = TicketRouter()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
         registerCell()
        bindingTableView()
      
        // Do any additional setup after loading the view.
    }


   

}
