//
//  HomeReportViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/10/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class HomeReportViewController: UIViewController {

      weak var timer: Timer?
    @IBOutlet weak var lbl_time: UILabel!
    
    @IBOutlet weak var lbl_date: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
        deinit {
            timer?.invalidate()
            timer = nil
        }
    
    func setup() {
        timer?.invalidate()
               timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                   self!.lbl_time.text = Utils.getDateString().today
                   self!.lbl_date.text = Utils.getDateString().dateTimeNow
               }

    }

   

}
