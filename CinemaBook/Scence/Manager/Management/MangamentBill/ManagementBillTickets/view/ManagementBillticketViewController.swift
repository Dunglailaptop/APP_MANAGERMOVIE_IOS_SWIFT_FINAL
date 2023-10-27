//
//  ManagementBillProductViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import JonAlert

class ManagementBillticketViewController: BaseViewController {

    var viewModel = ManagementBillticketViewModel()
    var router = ManagementBillticketRouter()
    
   
  
    @IBOutlet weak var view_nodata: UIView!
    @IBOutlet weak var lbl_date_to: UILabel!
    @IBOutlet weak var lbl_date_from: UILabel!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var tableView: UITableView!
    var type_choose_date = 0
    var status = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        register()
        bindingtable()
        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var data = viewModel.allvalue.value
        data.status = status
        viewModel.allvalue.accept(data)
        lbl_date_to.text = Utils.getCurrentDateString()
        lbl_date_from.text = Utils.getCurrentDateString()
        getListALLbill()
    }

    
    @IBAction func btn_showsearch(_ sender: Any) {
        view_search.isHidden = false
    }
    
    
    @IBAction func btn_closesearch(_ sender: Any) {
        view_search.isHidden = true
    }
    
    @IBAction func btn_showDateFrom(_ sender: Any) {
        showDateTimePicker(dataDateTime: Utils.getCurrentDateString())
        type_choose_date = 0
    }
    
    @IBAction func btn_showDateTo(_ sender: Any) {
        showDateTimePicker(dataDateTime: Utils.getCurrentDateString())
        type_choose_date = 1
    }
    
}



extension ManagementBillticketViewController {
    func getListALLbill() {
        viewModel.getListAllBill().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<BillInfoAccount>().mapArray(JSONObject: response.data)
                {
                    self.viewModel.dataArray.accept(data)
                    self.view_nodata.isHidden = self.viewModel.dataArray.value.count > 0 ? true:false
                }
            }
        })
    }
}
extension ManagementBillticketViewController: SambagDatePickerViewControllerDelegate {
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult) {
          dLog(result.description)
        var data = viewModel.allvalue.value
        if(type_choose_date == 0) {
            data.dateFrom = Utils().convertFormartDateyearMMddToString(date: result.description)!
            lbl_date_from.text = result.description
           
        } else {
          
            data.dateTo = Utils().convertFormartDateyearMMddToString(date: result.description)!
            lbl_date_to.text = result.description
        }
        viewModel.allvalue.accept(data)
        dLog(viewModel.allvalue.value)
        let from_date = viewModel.allvalue.value.dateFrom.components(separatedBy: "-")
        let to_date = viewModel.allvalue.value.dateTo.components(separatedBy: "-")
    
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
                datadate.dateFrom = Utils.getCurrentDateStringformatMysqlyymmdd()
                datadate.dateTo = Utils.getCurrentDateStringformatMysqlyymmdd()
            }else{
                lbl_date_to.text = Utils.getCurrentDateString()
                lbl_date_from.text = Utils.getCurrentDateString()
                var datadate = viewModel.allvalue.value
                datadate.dateFrom = Utils.getCurrentDateStringformatMysqlyymmdd()
                datadate.dateTo = Utils.getCurrentDateStringformatMysqlyymmdd()
             
            }
        }
        getListALLbill()
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
extension ManagementBillticketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

    
    func register() {
        let cellview = UINib(nibName: "ManagementBillProductItemTableViewCell", bundle: .main)
        tableView.register(cellview, forCellReuseIdentifier: "ManagementBillProductItemTableViewCell")
        tableView.rx.setDelegate(self)
        tableView.separatorStyle = .none
        tableView.rx.modelSelected(BillInfoAccount.self).subscribe(onNext: {
        element in
            self.viewModel.makeToViewControllerDetailBill(bill: element)
        })
    }
    
    func bindingtable() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ManagementBillProductItemTableViewCell", cellType: ManagementBillProductItemTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
}
