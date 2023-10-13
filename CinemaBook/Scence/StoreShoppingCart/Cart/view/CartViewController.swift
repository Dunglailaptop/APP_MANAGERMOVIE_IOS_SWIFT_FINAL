//
//  CartViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 13/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = CartViewModel()
    var router = CartRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        register()
        bindingtable()
       
        // Do any additional setup after loading the view.
    }


    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    

}
extension CartViewController: UITableViewDelegate {
    func register() {
        let cellTable = UINib(nibName: "ItemCartTableViewCell", bundle: .main)
        tableView.register(cellTable, forCellReuseIdentifier: "ItemCartTableViewCell")
        tableView.separatorStyle = .none
        tableView.rx.setDelegate(self)
    }
    func bindingtable() {
        viewModel.dataArrayFoodCombo.bind(to: tableView.rx.items(cellIdentifier: "ItemCartTableViewCell", cellType: ItemCartTableViewCell.self)) { (row,data,cell) in
            cell.selectionStyle = .none
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
