//
//  ManagementEmployee+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 9/11/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

extension ManagementEmployeeViewController {
    func getlistEmployee() {
        viewModel.getListEmployee().subscribe(onNext: { (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Users>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                }
            }
            
            }).disposed(by: rxbag)
    }
}
extension ManagementEmployeeViewController {
    func register() {
        let viewEmployeetableviewcell = UINib(nibName: "ItemEmployeeTableViewCell", bundle: .main)
        tableView.register(viewEmployeetableviewcell,forCellReuseIdentifier:"ItemEmployeeTableViewCell")
        tableView.separatorStyle = .none
      
        tableView.rx.setDelegate(self)
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using
    }
    @objc func refresh(_ sender: AnyObject) {
          // Code to refresh table view
         
           refreshControl.endRefreshing()
       }
    
    func bindingtablecell() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ItemEmployeeTableViewCell", cellType: ItemEmployeeTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
extension ManagementEmployeeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
}
