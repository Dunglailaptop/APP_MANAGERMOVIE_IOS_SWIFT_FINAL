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

class ManageBillFoodAccountViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var viewModel = ManageBillFoodAccountViewModel()
    var router = ManageBillFoodAccountRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        regiter()
        bindingtable()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListBillFoodCombo()
    }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopViewController()
    }
    

}
extension ManageBillFoodAccountViewController{
    func getListBillFoodCombo() {
        viewModel.getListBillFoodCombo().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<PaymentInfoBillFoodCombo>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
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
