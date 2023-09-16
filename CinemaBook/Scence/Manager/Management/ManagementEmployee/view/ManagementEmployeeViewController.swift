//
//  ManagementEmployeeViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/11/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class ManagementEmployeeViewController: BaseViewController {

    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ManagementEmployeeViewModel()
    var router = ManagementEmployeeRouter()
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        register()
        bindingtablecell()
       
        textfield_search.rx.controlEvent(.editingChanged)
                      .withLatestFrom(textfield_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                    self.viewModel.cleardata()
                    var data = self.viewModel.pagation.value
                    data.keysearch = query!
                    self.viewModel.pagation.accept(data)
                       
                    self.getlistEmployee()
                       
        }).disposed(by: rxbag)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var data = viewModel.pagation.value
        data.idcinema = ManageCacheObject.getCurrentCinema().idcinema
        viewModel.pagation.accept(data)
        viewModel.cleardata()
        getlistEmployee()
    }
    @IBAction func btn_makeToAccountinfoViewController(_ sender: Any) {
        viewModel.makeToAccountinfo(iduser: 0,note: "CREATE")
    }
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopTovViewController()
    }
}
