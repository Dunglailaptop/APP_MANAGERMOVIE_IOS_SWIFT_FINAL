//
//  DialogAccessViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/13/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class DialogAccessViewController: UIViewController {

    @IBOutlet weak var lbl_note: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_access(_ sender: Any) {
    }
    

}
