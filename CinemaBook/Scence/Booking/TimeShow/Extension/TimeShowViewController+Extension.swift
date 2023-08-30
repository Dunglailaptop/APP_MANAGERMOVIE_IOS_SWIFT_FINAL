//
//  TimeShowViewController+Extension.swift
//  CinemaBookTests
//
//  Created by dungtien on 8/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

extension TimeShowViewController{
    func register() {
        let DatePickerRowView = UINib(nibName: "DatePickerRowTableViewCell", bundle: .main)
        tableView.register(DatePickerRowView, forCellReuseIdentifier: "DatePickerRowTableViewCell")
        let ListcinemaView = UINib(nibName: "ListCinemaTableViewCell", bundle: .main)
        tableView.register(ListcinemaView, forCellReuseIdentifier: "ListCinemaTableViewCell")
        self.tableView.estimatedRowHeight = 80
               self.tableView.rowHeight = UITableView.automaticDimension
               tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
    }
    func bindingtableviewcell() {
        viewModel.dataArray.bind(to: tableView.rx.items){ [self] (table, index, employee) -> UITableViewCell in
                let indexPath = IndexPath(row: index, section: 0)
                    switch index {
                              case 0:
                               let cell = self.tableView.dequeueReusableCell(withIdentifier: "DatePickerRowTableViewCell", for: indexPath) as! DatePickerRowTableViewCell
                                    
                                  return cell
                              case 1:
                                let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListCinemaTableViewCell", for: indexPath) as! ListCinemaTableViewCell
                                cell.viewModel = self.viewModel
                                  
                                  return cell
                              default:
                                 let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListCinemaTableViewCell", for: indexPath) as! ListCinemaTableViewCell
                                                          
                                                         
                                 
                                  return cell
                              }
                  
                  
                              }.disposed(by: rxbag)
                      
                 }
}
    
extension TimeShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             switch indexPath.row {
             case 0:
                 return 150
             case 1:
                return CGFloat(viewModel.dataListCinema.value.count * 80)
             default:
                 return 200
             }
 
         }
}

