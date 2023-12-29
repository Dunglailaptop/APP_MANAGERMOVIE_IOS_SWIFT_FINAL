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
import JonAlert

extension ManagementBillFoodComboViewController {
    func getListBillAllFoodCombo() {
        viewModel.getListAllBillFoodCombo().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<PaymentInfoBillFoodCombo>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                    self.viewModel.dataArraySearch.accept(data)
                    dLog(data)
                    self.view_nodata.isHidden = self.viewModel.dataArray.value.count > 0 ? true : false
                }
            }
        })
    }
}
extension ManagementBillFoodComboViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func register() {
        let cellview = UINib(nibName: "ManagementBillFoodComboItemTableViewCell", bundle: .main)
        tableView.register(cellview, forCellReuseIdentifier: "ManagementBillFoodComboItemTableViewCell")
        tableView.rx.setDelegate(self)
        tableView.separatorStyle = .none
        tableView.rx.modelSelected(PaymentInfoBillFoodCombo.self).subscribe(onNext: {
            element in
            self.viewModel.makeToManageDetailViewController(Paymentinfobill: element)
        })
    }
    
    func bindingtable() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ManagementBillFoodComboItemTableViewCell", cellType: ManagementBillFoodComboItemTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
}
extension ManagementBillFoodComboViewController: SambagDatePickerViewControllerDelegate {
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult) {
          dLog(result.description)
        var data = viewModel.allvalue.value
        if(type_choose_date == 0) {
            data.datefrom = Utils().convertFormartDateyearMMddToString(date: result.description)!
            lbl_date_from.text = result.description
           
        } else {
          
            data.dateto = Utils().convertFormartDateyearMMddToString(date: result.description)!
            lbl_date_to.text = result.description
        }
        viewModel.allvalue.accept(data)
        dLog(viewModel.allvalue.value)
        let from_date = viewModel.allvalue.value.datefrom.components(separatedBy: "-")
        let to_date = viewModel.allvalue.value.dateto.components(separatedBy: "-")
    
        let from_date_in = String(format: "%@%@%@", from_date[2], from_date[1], from_date[0])
        let to_date_in = String(format: "%@%@%@", to_date[2], to_date[1], to_date[0])
        
        // MARK: Xét điều kiện ngày bắt đầu ko được lớn hơn ngày kết thúc
        dLog(from_date_in)
        dLog(to_date_in)
        if(from_date_in > to_date_in){
            JonAlert.show(message: "Ngày bắt đầu không được lớn hơn ngày kết thúc!", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
            if(type_choose_date == 0){
                lbl_date_to.text = Utils.getCurrentDateString()
                lbl_date_from.text = Utils.getCurrentDateString()
                var datadate = viewModel.allvalue.value
                datadate.datefrom = Utils.getCurrentDateStringformatMysqlyymmdd()
                datadate.dateto = Utils.getCurrentDateStringformatMysqlyymmdd()
            }else{
                lbl_date_to.text = Utils.getCurrentDateString()
                lbl_date_from.text = Utils.getCurrentDateString()
                var datadate = viewModel.allvalue.value
                datadate.datefrom = Utils.getCurrentDateStringformatMysqlyymmdd()
                datadate.dateto = Utils.getCurrentDateStringformatMysqlyymmdd()
             
            }
        }
       getListBillAllFoodCombo()
          viewController.dismiss(animated: true, completion: nil)
      }

      func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
          viewController.dismiss(animated: true, completion: nil)
      }

      func showDateTimePicker(dataDateTime : String){
          let vc = SambagDatePickerViewController()
          var limit = SambagSelectionLimit()
          var dateNow = Date()
          let dateString = dataDateTime
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd/MM/yyyy"
          dateNow = dateFormatter.date(from: dateString)!
          limit.selectedDate = dateNow
          
          let currentDate = Date()
          let minDate = Calendar.current.date(byAdding: .year, value: -1000, to: currentDate)
          let maxDate = Calendar.current.date(byAdding: .year, value: 1000, to: currentDate)
          
          limit.minDate = minDate
          limit.maxDate = maxDate
          vc.limit = limit
          vc.delegate = self
          present(vc, animated: true, completion: nil)
      }
}
