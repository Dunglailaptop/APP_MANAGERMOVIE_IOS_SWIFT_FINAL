//
//  ManagementVoucherViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper

class ManagementVoucherViewController:  BaseViewController {

    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var viewModel = ManagementVoucherViewModel()
    var router = ManagementVoucherRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgister()
        bindingtable()
     
        txt_search.rx.controlEvent(.editingChanged)
                   .withLatestFrom(txt_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       guard self != nil else { return }
                
                       let dataFirsts = viewModel.dataArraysearch.value
                       let cloneDataFilter = viewModel.dataArray.value
                       if !query!.isEmpty{
                           var filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               let str2 = value.namevoucher.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               return str2!.contains(str1!)
                           })
                           viewModel.dataArray.accept(filteredDataArray)
                           tableview.reloadData()
                       }else{
                           viewModel.dataArray.accept(dataFirsts)
                           tableview.reloadData()
                          
                       }
                       
                   }).disposed(by: rxbag)
        getListVoucher()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListVoucher()
    }


    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
       
    }
    @IBAction func btn_makeToCreateVoucherViewController(_ sender: Any) {
        viewModel.makeToDetailViewController(idvoucher: 0, type: "CREATE")
    }
    

}
extension ManagementVoucherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func resgister() {
        let viewcell = UINib(nibName: "ItemVoucherTableViewCell", bundle: .main)
        tableview.register(viewcell, forCellReuseIdentifier: "ItemVoucherTableViewCell")
        tableview.rx.setDelegate(self)
        tableview.separatorStyle = .none
        tableview.rx.modelSelected(voucher.self).subscribe(onNext: {
            element in
            self.viewModel.makeToDetailViewController(idvoucher: element.idvoucher,type: "UPDATE")
        })
    }
    
    func bindingtable() {
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "ItemVoucherTableViewCell", cellType: ItemVoucherTableViewCell.self)) {
            (row,data,cell) in
            cell.selectionStyle = .none
            cell.data = data
        }
    }
    
}
extension ManagementVoucherViewController {
    func getListVoucher() {
        viewModel.getListVoucherShowBanner().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<voucher>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArraysearch.accept(data)
                    self.viewModel.dataArray.accept(data)
                    
                }
            }
        })
    }
}
extension ManagementVoucherViewController {
    
 
}
