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
   
    @IBOutlet weak var lbl_category_reduce: UILabel!
    
    @IBOutlet weak var icon_check_1: UIImageView!
    
    @IBOutlet weak var icon_check_2: UIImageView!
    
    @IBOutlet weak var lbl_name_cinema: UILabel!
    @IBOutlet weak var view_voucher: UIView!
    @IBOutlet weak var view_no_datat: UIView!
    @IBOutlet weak var tableviewvoucher: UITableView!
    @IBOutlet weak var lbl_total_final: UILabel!
    @IBOutlet weak var lbl_total_vat: UILabel!
    @IBOutlet weak var height_cell: NSLayoutConstraint!
    @IBOutlet weak var height_scroll: NSLayoutConstraint!
    @IBOutlet weak var height_voucher: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var data = [FoodCombo]()
    var idcinema = 0
    var dateorder = ""
    var namecinema = ""
    var checkcategoryPay = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        viewModel.dataArrayFoodCombo.accept(data)
        resgiter()
        bindingtable()
        resgistervoucher()
        bindingtablevoucher()
        setup()
        getDataPaymentBillFoodCombo()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name ("idbillcheckPaymentVNPAY"), object: nil)

    }
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any] {
                // Access the loginResponse dictionary here
                if let reportType = userInfo["userInfo"] as? [String: Any] {
                    let reportTypeValue = reportType["Report_type"] as? Int ?? 0
                
                    checkIdbill()
                }
            }
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         getListVoucher()
         lbl_name_cinema.text = "Rạp nhận: " + namecinema
    }
    
    @IBAction func btn_choose_order_point(_ sender: Any) {
        checkcategoryPay = 0
        icon_check_1.image = UIImage(named: "check")
        icon_check_2.image = UIImage(named: "icon-check-disable")
    }
    
    @IBAction func btn_choose_VNPAY(_ sender: Any) {
        checkcategoryPay = 1
        icon_check_1.image = UIImage(named: "icon-check-disable")
        icon_check_2.image = UIImage(named: "check")
    }
    
    func getDataPaymentBillFoodCombo() {
        var data = viewModel.dataArrayFoodCombo.value
        var dataFoodCombobill = viewModel.dataArrayBillPayment.value
        dataFoodCombobill.total_price = data.map{ $0.quantityRealtime * $0.priceCombo}.reduce(0,+)
        dataFoodCombobill.numbers = data.map{ $0.quantityRealtime}.reduce(0, +)
        dataFoodCombobill.iduser = ManageCacheObject.getCurrentUserInfo().idusers
        dataFoodCombobill.idcinemas = idcinema
//        dataFoodCombobill.idcinemas = ManageCacheObject.getCurrentCinema().idcinema
        data.enumerated().forEach{
            (index,value) in
            var dataonly = FoodComboList()
            dataonly.idfoodcombo = value.idcombo
            dataFoodCombobill.foodComboBills.append(dataonly)
        }
        viewModel.dataArrayBillPayment.accept(dataFoodCombobill)
//        if viewModel.dataArrayBillPaymentHistory.value == nil {
            viewModel.dataArrayBillPaymentHistory.accept(dataFoodCombobill)
//        }
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
        checkcategoryPay == 0 ?  paymentBillFoodCombo() : saveCacheBillFoodCombo()
        
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
extension PaymentFoodComboViewController {
    func resgistervoucher() {
        let celltable = UINib(nibName: "ItemVoucherFoodPaymentTableViewCell", bundle: .main)
        tableviewvoucher.register(celltable, forCellReuseIdentifier: "ItemVoucherFoodPaymentTableViewCell")
        tableviewvoucher.separatorStyle = .none
        tableviewvoucher.rx.modelSelected(voucher.self).subscribe(onNext: {
           [self] (element) in
            var dataVoucher = viewModel.dataVoucher.value
            var dataAllbill = viewModel.dataArrayBillPayment.value
        
            var dataHistory = viewModel.dataArrayBillPaymentHistory.value
            dataVoucher.enumerated().forEach{
                (index,value) in
                if value.idvoucher == element.idvoucher {
                    dataVoucher[index].isCheck = value.isCheck == ACTIVE ? DEACTIVE:ACTIVE
                    if dataVoucher[index].isCheck == ACTIVE {
                        dataAllbill.idvoucher = element.idvoucher
                        if element.price != 0 {
                            lbl_total_vat.text = Utils.stringVietnameseFormatWithNumber(amount: dataHistory.total_price - element.price)
                            lbl_total_final.text = Utils.stringVietnameseFormatWithNumber(amount:  dataHistory.total_price - element.price)
                            dataAllbill.total_price = dataHistory.total_price - element.price
                            lbl_category_reduce.text = Utils.stringVietnameseFormatWithNumber(amount: element.price)
                        }
                        if element.percent != 0 {
                            var percent = element.percent // Retrieve the percentage value
                            var percentageValue = (Double(percent) / 100) * Double(dataHistory.total_price) //
                            var totalAfterPercentage = dataHistory.total_price - Int(percentageValue)
                            dataAllbill.total_price = totalAfterPercentage
                            lbl_total_vat.text = Utils.stringQuantityFormatWithNumber(amount: totalAfterPercentage)
                            lbl_total_final.text = Utils.stringQuantityFormatWithNumber(amount: totalAfterPercentage)
                            lbl_category_reduce.text =  String(element.percent) + "%"
                        }
                    }else {
                        lbl_total_vat.text = Utils.stringQuantityFormatWithNumber(amount: dataHistory.total_price)
                        lbl_total_final.text = Utils.stringQuantityFormatWithNumber(amount: dataHistory.total_price)
                        lbl_category_reduce.text =  "0"
                    }
                    
                 
                    
                }else {
                    dataVoucher[index].isCheck = DEACTIVE
                }
            }
            viewModel.dataVoucher.accept(dataVoucher)
            viewModel.dataArrayBillPayment.accept(dataAllbill)
        })
    }
    func bindingtablevoucher() {
        viewModel.dataVoucher.bind(to: tableviewvoucher.rx.items(cellIdentifier: "ItemVoucherFoodPaymentTableViewCell",cellType: ItemVoucherFoodPaymentTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
    
}
