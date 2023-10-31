//
//  ReportTicketALLViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 31/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ReportTicketALLViewController: UIViewController {

    var viewModel = ReportTicketALLViewModel()
    var router = ReportTicketALLRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
       
    }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    
    


}
extension ReportTicketALLViewController {
    
}
