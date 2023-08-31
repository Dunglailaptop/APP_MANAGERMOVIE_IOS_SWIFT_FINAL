//
//  AccountViewController+Extension.swift
//  CinemaBookTests
//
//  Created by dungtien on 8/31/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift

extension AccountViewController {
    func register() {
        let settingaccountview = UINib(nibName: "SettingforAccountCustomerTableViewCell", bundle: .main)
        tableView.register(settingaccountview, forCellReuseIdentifier: "SettingforAccountCustomerTableViewCell")
        let LogoutTableViewCell = UINib(nibName: "LogoutTableViewCell", bundle: .main)
               tableView.register(LogoutTableViewCell, forCellReuseIdentifier: "LogoutTableViewCell")
        self.tableView.estimatedRowHeight = 80
             self.tableView.rowHeight = UITableView.automaticDimension
             tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        
    }
    func bindingtableview() {
        viewModel.dataArray.bind(to: tableView.rx.items) {
            [self] (table, index, data) -> UITableViewCell in
            let indexPath = IndexPath(row: index, section: 0)
            switch index {
            case 0:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "SettingforAccountCustomerTableViewCell", for: indexPath) as! SettingforAccountCustomerTableViewCell
                return cell
            case 1:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as! LogoutTableViewCell
                cell.btn_logout.rx.tap.asDriver().drive(onNext: { [weak self]  in
                    self?.logout()
                }).disposed(by: self.rxbag)
                
                return cell
            default:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as! LogoutTableViewCell
                return cell
            }
        }.disposed(by: rxbag)
    }
}
extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
        case 1:
            return 60
        default:
            return 0
        }
    }
}
