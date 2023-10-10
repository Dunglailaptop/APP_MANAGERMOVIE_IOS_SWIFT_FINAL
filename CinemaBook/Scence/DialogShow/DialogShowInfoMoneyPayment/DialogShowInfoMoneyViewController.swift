//
//  DialogShowInfoMoneyViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 10/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class DialogShowInfoMoneyViewController: UIViewController {

    @IBOutlet weak var lbl_total_bill: UILabel!
    var Delegate: DialogPayment?
    var totalbill = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_total_bill.text = Utils.stringVietnameseFormatWithNumber(amount: totalbill)
    }


    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_access(_ sender: Any) {
        Delegate?.callbackPayment()
    }
    
}
