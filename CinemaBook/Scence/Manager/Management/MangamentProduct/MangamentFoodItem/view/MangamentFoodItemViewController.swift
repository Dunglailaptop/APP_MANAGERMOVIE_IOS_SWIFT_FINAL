//
//  MangamentFoodItemViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ObjectMapper

class MangamentFoodItemViewController: UIViewController {
    var viewModel = MangamentFoodItemViewModel()
    var router = MangamentFoodItemRouter()
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router:  router)
        register()
        bindingtableviewcell()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListFood()
    }
   

}
extension MangamentFoodItemViewController {
    func getListFood() {
        viewModel.getListFood().subscribe(onNext: {(response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Food>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                   
                }
            }
        })
    }
}

extension MangamentFoodItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func register() {
        let celltable = UINib(nibName: "ItemFoodInManagementTableViewCell", bundle: .main)
        tableview.register(celltable, forCellReuseIdentifier: "ItemFoodInManagementTableViewCell")
        tableview.separatorStyle = .none
        tableview.rx.setDelegate(self)
    }
    
    func bindingtableviewcell() {
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "ItemFoodInManagementTableViewCell", cellType: ItemFoodInManagementTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
}
