//
//  ManagementBillFoodComboViewController + Extensions.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 17/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper

extension ManagementBillFoodComboViewController {
    func getListBillAllFoodCombo() {
        viewModel.getListAllBillFoodCombo().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<PaymentInfoBillFoodCombo>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                    dLog(data)
                }
            }
        })
    }
}
extension ManagementBillFoodComboViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func register() {
        let cellview = UINib(nibName: "ManagementBillFoodComboItemTableViewCell", bundle: .main)
        tableView.register(cellview, forCellReuseIdentifier: "ManagementBillFoodComboItemTableViewCell")
        tableView.rx.setDelegate(self)
        tableView.separatorStyle = .none
    }
    
    func bindingtable() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ManagementBillFoodComboItemTableViewCell", cellType: ManagementBillFoodComboItemTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
}
