//
//  DialogNotPaymentViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 10/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class DialogNotPaymentViewController: UIViewController {

    var delegate: DialogNotPayment?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func btn_AccessDialog(_ sender: Any) {
        delegate?.callBackDialogNotPayment()
    }
    
}
