//
//  ManageBillAccountViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 15/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class ManageBillAccountViewController: UIViewController {

    @IBOutlet weak var lbl_tittle_1: UILabel!
    @IBOutlet weak var lbl_tittle_2: UILabel!
    @IBOutlet weak var view_choose_order_success: UIView!
    @IBOutlet weak var view_choose_order: UIView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ManageBillAccountViewModel()
    var router = ManageBillAccountRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        regiter()
        bindingtable()
    }


    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func btn_choose_ticket_new(_ sender: Any) {
        lbl_tittle_1.textColor = .systemBlue
        lbl_tittle_2.textColor = .black
        view_choose_order.backgroundColor = .systemBlue
        view_choose_order_success.backgroundColor = .clear
    }
            
    
    @IBAction func btn_choose_order_success(_ sender: Any) {
        lbl_tittle_1.textColor = .black
        lbl_tittle_2.textColor = .systemBlue
        view_choose_order.backgroundColor = .clear
        view_choose_order_success.backgroundColor = .systemBlue
    }
    
}
extension ManageBillAccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func regiter() {
        let celltableItemBill = UINib(nibName: "ManageBillAccountItemTableViewCell", bundle: .main)
        tableView.register(celltableItemBill, forCellReuseIdentifier: "ManageBillAccountItemTableViewCell")
        tableView.rx.setDelegate(self)
        tableView.separatorStyle = .none
    }
    func bindingtable() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ManageBillAccountItemTableViewCell", cellType: ManageBillAccountItemTableViewCell.self)) {
            (row,data,cell) in
            cell.selectionStyle = .none
           
        }
    }
}
