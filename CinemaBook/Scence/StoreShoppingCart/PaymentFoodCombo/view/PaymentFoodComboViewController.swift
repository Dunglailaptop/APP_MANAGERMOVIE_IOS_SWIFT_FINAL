//
//  PaymentFoodComboViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 14/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift


class PaymentFoodComboViewController: UIViewController {
    
    var viewModel = PaymentFoodComboViewModel()
    var router = PaymentFoodComboRouter()
   
    @IBOutlet weak var lbl_total_final: UILabel!
    @IBOutlet weak var lbl_total_vat: UILabel!
    @IBOutlet weak var height_cell: NSLayoutConstraint!
    @IBOutlet weak var height_scroll: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var data = [FoodCombo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        viewModel.dataArrayFoodCombo.accept(data)
        resgiter()
        bindingtable()
        setup()
        getDataPaymentBillFoodCombo()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
      
    }
    
    func getDataPaymentBillFoodCombo() {
        var data = viewModel.dataArrayFoodCombo.value
        var dataFoodCombobill = viewModel.dataArrayBillPayment.value
        dataFoodCombobill.total_price = data.map{ $0.quantityRealtime * $0.priceCombo}.reduce(0,+)
        dataFoodCombobill.numbers = data.map{ $0.quantityRealtime}.reduce(0, +)
        dataFoodCombobill.iduser = ManageCacheObject.getCurrentUserInfo().idusers
        data.enumerated().forEach{
            (index,value) in
            var dataonly = FoodComboList()
            dataonly.idfoodcombo = value.idcombo
            dataFoodCombobill.foodComboBills.append(dataonly)
        }
        viewModel.dataArrayBillPayment.accept(dataFoodCombobill)
        dLog(viewModel.dataArrayBillPayment.value)
    }
    
    func setup() {
        lbl_total_vat.text = Utils.stringVietnameseFormatWithNumber(amount: data.map{ $0.priceCombo * $0.quantityRealtime}.reduce(0, +))
        lbl_total_final.text = Utils.stringVietnameseFormatWithNumber(amount: data.map{ $0.priceCombo * $0.quantityRealtime}.reduce(0, +))
    }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.maKeToViewController()
    }
    
    @IBAction func btn_paymentFoodCombo(_ sender: Any) {
       paymentBillFoodCombo()
        
    }
    
    
}
extension PaymentFoodComboViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func resgiter() {
        let celltable = UINib(nibName: "ItemPaymentFoodComboTableViewCell", bundle: .main)
        tableView.register(celltable, forCellReuseIdentifier: "ItemPaymentFoodComboTableViewCell")
        tableView.rx.setDelegate(self)
        height_cell.constant = CGFloat(viewModel.dataArrayFoodCombo.value.count * 150)
        height_scroll.constant = height_cell.constant + 750
    }
    
    func bindingtable() {
        viewModel.dataArrayFoodCombo.bind(to: tableView.rx.items(cellIdentifier: "ItemPaymentFoodComboTableViewCell", cellType: ItemPaymentFoodComboTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
