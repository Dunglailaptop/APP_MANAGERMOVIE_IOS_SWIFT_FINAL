//
//  ManagementCheckinEmployeeViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementCheckinEmployeeViewController: BaseViewController {

    
    var view1 = SystemCheckinViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupViewOrderProductViewController()
        // Do any additional setup after loading the view.
    }
    func setupViewOrderProductViewController() {
        addTopCustomViewController(view1, addTopCustom: 70)

    }

}
