//
//  DialogViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class DialogViewController: BaseViewController {

    var delegate: LogoutConfirm?
    var tittle:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_Access(_ sender: Any) {
        delegate?.callbackAccessConfirm()
    }
    
}
