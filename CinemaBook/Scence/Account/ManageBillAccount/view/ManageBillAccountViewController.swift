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
import ObjectMapper

class ManageBillAccountViewController: BaseViewController {

    @IBOutlet weak var txt_search: UITextField!
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
        txt_search.rx.controlEvent(.editingChanged)
                   .withLatestFrom(txt_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       guard self != nil else { return }
                
                       let dataFirsts = viewModel.dataArraySearch.value
                       let cloneDataFilter = viewModel.dataArray.value
                       if !query!.isEmpty{
                           var filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               let str2 = value.namemovie.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               return str2!.contains(str1!)
                           })
                           viewModel.dataArray.accept(filteredDataArray)
                          
                       }else{
                           viewModel.dataArray.accept(dataFirsts)
                           
                          
                       }
                       
                   }).disposed(by: rxbag)
        viewModel.status.accept(1)
        getListBillAccount()
    }


    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func btn_choose_ticket_new(_ sender: Any) {
        lbl_tittle_1.textColor = .systemBlue
        lbl_tittle_2.textColor = .black
        view_choose_order.backgroundColor = .systemBlue
        view_choose_order_success.backgroundColor = .clear
        viewModel.status.accept(1)
        getListBillAccount()
    }
            
    
    @IBAction func btn_choose_order_success(_ sender: Any) {
        lbl_tittle_1.textColor = .black
        lbl_tittle_2.textColor = .systemBlue
        view_choose_order.backgroundColor = .clear
        view_choose_order_success.backgroundColor = .systemBlue
        viewModel.status.accept(0)
        getListBillAccount()
    }
    
}

extension ManageBillAccountViewController {
    func getListBillAccount() {
        viewModel.getListBillInAccount().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<BillInfoAccount>().mapArray(JSONObject: response.data) {
                    dLog(data)
                    self.viewModel.dataArray.accept(data)
                    self.viewModel.dataArraySearch.accept(data)
                }
            }
        })
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
        tableView.rx.modelSelected(BillInfoAccount.self).subscribe(onNext: {
            [self] (element) in
            dLog(element)
            viewModel.makeToDetailBillInfoAccount(BillInfo: element)
        })
    }
    func bindingtable() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ManageBillAccountItemTableViewCell", cellType: ManageBillAccountItemTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
           
        }
    }
}
