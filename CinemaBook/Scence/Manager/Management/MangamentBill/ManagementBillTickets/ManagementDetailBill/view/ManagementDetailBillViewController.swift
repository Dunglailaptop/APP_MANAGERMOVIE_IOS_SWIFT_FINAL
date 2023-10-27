//
//  ManagementDetailBillViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 26/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class ManagementDetailBillViewController: UIViewController {

    @IBOutlet weak var view_no_data_combolist: UIView!
    @IBOutlet weak var view_no_data_listchair: UIView!
    @IBOutlet weak var tableview2: UITableView!
    @IBOutlet weak var lbl_number_ticket_total: UILabel!
    @IBOutlet weak var lbl_total_bill: UILabel!
    @IBOutlet weak var view_status: UILabel!
    @IBOutlet weak var lbl_room: UILabel!
    @IBOutlet weak var lbl_time_all: UILabel!
    @IBOutlet weak var lbl_date_interest: UILabel!
    @IBOutlet weak var lbl_name_movie: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_idBill: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var viewModel = ManagementDetailBillViewModel()
    var router = ManagementDetailBillRouter()
    var infobill = BillInfoAccount()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgister()
        bindingtableview()
        resgister2()
        bindingtableview2()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.idbill.accept(infobill.idbill)
        getDetailBill()
    }
    

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
}
