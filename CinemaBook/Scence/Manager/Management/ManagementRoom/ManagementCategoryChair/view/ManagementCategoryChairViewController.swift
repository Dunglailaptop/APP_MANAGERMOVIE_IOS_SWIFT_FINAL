//
//  ManagementCategoryChairViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementCategoryChairViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        bindingtable()
        // Do any additional setup after loading the view.
    }

    var viewModel: ManagementRoomViewModel? = nil {
        didSet {
            viewModel?.dataArrayCategoryChair.subscribe(onNext: {
                (respone) in
              
            })
        }
    }

    

}
extension ManagementCategoryChairViewController {
    func register() {
        let cell = UINib(nibName: "ItemCategoryChairTableViewCell", bundle: .main)
        tableView.register(cell, forCellReuseIdentifier: "ItemCategoryChairTableViewCell")
        tableView.separatorStyle = .none
        
    }
    
    func bindingtable() {
        viewModel?.dataArrayCategoryChair.bind(to: tableView.rx.items(cellIdentifier: "ItemCategoryChairTableViewCell", cellType: ItemCategoryChairTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
}
