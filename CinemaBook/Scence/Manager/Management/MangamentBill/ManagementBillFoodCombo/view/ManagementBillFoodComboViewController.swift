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

    var viewModel = ManagementBillFoodComboViewModel()
    var router = ManagementBillFoodComboRouter()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
       register()
        bindingtable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListBillAllFoodCombo()
    }

}
