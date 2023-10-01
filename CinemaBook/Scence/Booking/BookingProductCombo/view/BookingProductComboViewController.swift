//
//  BookingProductComboViewController.swift
//  CinemaBook
//
//  Created by dungtien on 10/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BookingProductComboViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var viewModel = BookingProductComboViewModel()
    var router = BookingProductComboRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        register()
        bindingtablecell()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListCombo()
    }

  
}
extension BookingProductComboViewController: UITableViewDelegate {
    func register() {
        let cellview = UINib(nibName: "ItemProductComboTableViewCell", bundle: .main)
        tableview.register(cellview, forCellReuseIdentifier: "ItemProductComboTableViewCell")
        tableview.separatorStyle = .none
        tableview.rx.setDelegate(self)
    }
    
    func bindingtablecell() {
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "ItemProductComboTableViewCell", cellType: ItemProductComboTableViewCell.self))
        { (row,data,cell) in
            cell.data = data
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
