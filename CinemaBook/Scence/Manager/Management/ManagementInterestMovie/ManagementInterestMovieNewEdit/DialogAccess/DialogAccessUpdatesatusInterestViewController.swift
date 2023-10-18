//
//  DialogAccessUpdatesatusInterestViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 18/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class DialogAccessUpdatesatusInterestViewController: UIViewController {

    @IBOutlet weak var lbl_tittle: UILabel!
    var delegate: DialogUpdateSatusInterest?
    var status = 0
    var idinterest = 0
    var tittle = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
     
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_tittle.text = tittle
    }

    @IBAction func btn_cancel(_ sender: Any) {
     dismiss(animated: true)
    }
    
    @IBAction func btn_access(_ sender: Any) {
        dLog(status)
        dLog(idinterest)
        delegate?.callbackUpdatesatusInterest(idinterest: idinterest, status: status)
    }
    

}
