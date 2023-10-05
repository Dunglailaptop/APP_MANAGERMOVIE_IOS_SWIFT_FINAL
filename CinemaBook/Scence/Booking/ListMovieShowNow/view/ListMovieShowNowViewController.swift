//
//  ListMovieShowNowViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ListMovieShowNowViewController: BaseViewController {

    var viewModel = ListMovieShowNowViewModel()
    var router = ListMovieShowNowRouter()
    
    var status = 0
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgisterCollection()
        binđDataTableCollectionView()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var data = viewModel.allvalue.value
        data.status = status
        viewModel.allvalue.accept(data)
        getListmovie()
    }
 

}
