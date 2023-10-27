//
//  ManagementBillTicketViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class ManagementBillFoodComboViewController: BaseViewController {

    @IBOutlet weak var view_nodata: UIView!
    @IBOutlet weak var lbl_date_from: UILabel!
    
    @IBOutlet weak var lbl_date_to: UILabel!
    @IBOutlet weak var view_search: UIView!
    var viewModel = ManagementBillFoodComboViewModel()
    var router = ManagementBillFoodComboRouter()
    @IBOutlet weak var tableView: UITableView!
    var type_choose_date = 0
    var status = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
       register()
        bindingtable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var allvalues = viewModel.allvalue.value
        allvalues.status = status
        viewModel.allvalue.accept(allvalues)
        lbl_date_from.text = Utils.getCurrentDateString()
        lbl_date_to.text = Utils.getCurrentDateString()
        getListBillAllFoodCombo()
    }

    @IBAction func btn_closesearch(_ sender: Any) {
        view_search.isHidden = true
    }
    
    @IBAction func btn_opensearch(_ sender: Any) {
        view_search.isHidden = false
    }
    
    @IBAction func btn_showDatefrom(_ sender: Any) {
        showDateTimePicker(dataDateTime: Utils.getCurrentDateString())
        type_choose_date = 0
    }
    
    @IBAction func btn_showDateto(_ sender: Any) {
        showDateTimePicker(dataDateTime: Utils.getCurrentDateString())
        type_choose_date = 1
    }
}
