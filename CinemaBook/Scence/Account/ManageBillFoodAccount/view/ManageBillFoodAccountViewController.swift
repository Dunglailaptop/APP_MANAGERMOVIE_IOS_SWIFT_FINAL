//
//  ManageBillFoodAccountViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 16/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay
import JonAlert
import ObjectMapper

class ManageBillFoodAccountViewController: BaseViewController {

    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var btn_successorder: UIButton!
    @IBOutlet weak var btn_neworder: UIButton!
    @IBOutlet weak var tableview: UITableView!
    var viewModel = ManageBillFoodAccountViewModel()
    var router = ManageBillFoodAccountRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        regiter()
        bindingtable()
        txt_search.rx.controlEvent(.editingChanged)
            .withLatestFrom(txt_search.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }
                
                let dataFirsts = self.viewModel.dataArraySearch.value
                let cloneDataFilter = self.viewModel.dataArray.value
                
                if !query.isEmpty {
                    let filteredDataArray = cloneDataFilter.filter { value in
                        let str1 = query.uppercased().applyingTransform(.stripDiacritics, reverse: false) ?? ""
                        
                        // Convert value.id to String before using uppercased()
                        if let stringValue = String(value.id).uppercased().applyingTransform(.stripDiacritics, reverse: false) {
                            return stringValue.contains(str1)
                        }
                        
                        return false // Handle if conversion fails or value.id is not convertible to String
                    }
                    self.viewModel.dataArray.accept(filteredDataArray)
                } else {
                    self.viewModel.dataArray.accept(dataFirsts)
                }
            })
            .disposed(by: rxbag)


        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.statusbillfood.accept(0)
        getListBillFoodCombo()
    }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func btn_statusbillfood_neworder(_ sender: Any) {
        btn_neworder.backgroundColor = .systemBlue
        btn_neworder.setTitleColor(UIColor.white, for: .normal)
        btn_successorder.backgroundColor = .white
        btn_successorder.setTitleColor(UIColor.systemBlue, for: .normal)
        viewModel.statusbillfood.accept(0)
        getListBillFoodCombo()
    }
    
    @IBAction func btn_statusbillfood_success(_ sender: Any) {
        btn_successorder.backgroundColor = .systemBlue
        btn_successorder.setTitleColor(UIColor.white, for: .normal)
        btn_neworder.backgroundColor = .white
        btn_neworder.setTitleColor(UIColor.systemBlue, for: .normal)
        viewModel.statusbillfood.accept(1)
        getListBillFoodCombo()
    }
}
extension ManageBillFoodAccountViewController{
    func getListBillFoodCombo() {
        viewModel.getListBillFoodCombo().subscribe(onNext: {
            (response) in
            dLog(response.data)
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<PaymentInfoBillFoodCombo>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                    self.viewModel.dataArraySearch.accept(data)
                    dLog(self.viewModel.dataArray.value)
                }
            }
        })
    }
}
extension ManageBillFoodAccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func regiter() {
        
        let cellTable = UINib(nibName: "ManageBillFoodAccountItemTableViewCell", bundle: .main)
        tableview.register(cellTable, forCellReuseIdentifier: "ManageBillFoodAccountItemTableViewCell")
        tableview.rx.setDelegate(self)
        tableview.rx.modelSelected(PaymentInfoBillFoodCombo.self).subscribe(onNext: { element in
            self.viewModel.makeDetailBillFoodAccountViewController(foodcombo: element)
        })
        
        tableview.separatorStyle = .none
    }
    
    func bindingtable() {
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "ManageBillFoodAccountItemTableViewCell", cellType: ManageBillFoodAccountItemTableViewCell.self))
        { (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
}
