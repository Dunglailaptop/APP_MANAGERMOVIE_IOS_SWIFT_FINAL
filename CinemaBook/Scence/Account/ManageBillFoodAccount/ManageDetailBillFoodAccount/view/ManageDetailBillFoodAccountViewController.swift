//
//  ManageDetailBillFoodAccountViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 16/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay
import ObjectMapper

class ManageDetailBillFoodAccountViewController: UIViewController {

    @IBOutlet weak var lbl_cinema: UILabel!
    @IBOutlet weak var lbl_datetime: UILabel!
    @IBOutlet weak var lbl_status_bill: UILabel!
    @IBOutlet weak var lbl_price_billfoodcombo: UILabel!
    @IBOutlet weak var lbl_quantity: UILabel!
    @IBOutlet weak var lbl_id_billfoodcombo: UILabel!
    var viewModel = ManageDetailBillFoodAccountViewModel()
    var router = ManageDetailBillFoodAccountRouter()
    var foodcombo = PaymentInfoBillFoodCombo()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        register()
        bindingtable()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewModel.dataArray.accept(foodcombo.listfoodcombo)
        foodcombo.listfoodcombo.enumerated().forEach{
            (index,value) in
            var datalistfood = foodcombo.listfood.filter{$0.idcombo == value.idcombo}
            foodcombo.listfoodcombo[index].listfoods.append(contentsOf: datalistfood)
        }
        viewModel.dataArray.accept(foodcombo.listfoodcombo)
        tableView.reloadData()
        setup()
//        getListBillFoodCombo()
    }

    func setup() {
        lbl_price_billfoodcombo.text = Utils.stringVietnameseFormatWithNumber(amount: foodcombo.total_prices)
        lbl_quantity.text = String(foodcombo.quantity)
        lbl_cinema.text = String(foodcombo.namecinema)
        lbl_datetime.text = foodcombo.time
        lbl_status_bill.text = foodcombo.status == 0 ? "Chưa nhận":"Đã nhận"
        lbl_status_bill.textColor = foodcombo.status == 0 ? .red : .green
        lbl_id_billfoodcombo.text = String(foodcombo.id)
    }
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopViewController()
    }
}
extension ManageDetailBillFoodAccountViewController {
  
}

extension ManageDetailBillFoodAccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func register() {
        let celltable = UINib(nibName: "ManageDetailBillFoodComboItemTableViewCell", bundle: .main)
        tableView.register(celltable, forCellReuseIdentifier: "ManageDetailBillFoodComboItemTableViewCell")
        tableView.rx.setDelegate(self)
        tableView.separatorStyle = .none
    }
    
    func bindingtable() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ManageDetailBillFoodComboItemTableViewCell", cellType: ManageDetailBillFoodComboItemTableViewCell.self)) {(row,data,cell) in
            cell.data = data
            cell.viewModel = self.viewModel
            cell.selectionStyle = .none
        }
    }
}
