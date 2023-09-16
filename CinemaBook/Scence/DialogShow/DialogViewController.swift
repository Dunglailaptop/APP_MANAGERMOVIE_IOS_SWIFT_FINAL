//
//  DialogViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class DialogViewController: BaseViewController {

    @IBOutlet weak var lbl_note: UILabel!
    var delegate: LogoutConfirm?
    var delegate2: DialogAccessEmployee?
    var tittle:String = ""
    var type = 0
    var idemployee = 0
    var status = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_note.text = tittle
    }

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_Access(_ sender: Any) {
        if type == 1{
             delegate?.callbackAccessConfirm()
        }else
        {
            delegate2?.callbackDialogAccess(id: idemployee,status: status)
        }
    }
    
}
