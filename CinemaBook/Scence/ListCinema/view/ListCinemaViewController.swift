//
//  ListCinemaViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 26/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import JonAlert

class ListCinemaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ListCinemaViewModel()
    var router = ListCinemaRouter()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgiter()
        BindingtableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListCinema()
    }


    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
}
extension ListCinemaViewController {
    func getListCinema() {
        viewModel.getlistCinema().subscribe(onNext: {
            [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Cinema>().mapArray(JSONObject: response.data){
                    viewModel.dataCinema.accept(data)
                }
            }else {
                JonAlert.showError(message: "Có lỗi xảy ra trong quá trình kết nối")
            }
        })
    }
    

    
}
extension ListCinemaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func resgiter() {
        let celltable = UINib(nibName: "ItemCinemasTableViewCell", bundle: .main)
        tableView.register(celltable, forCellReuseIdentifier: "ItemCinemasTableViewCell")
        tableView.rx.setDelegate(self)
        tableView.rx.modelSelected(Cinema.self).subscribe(onNext: {
            element in
            self.viewModel.makeToDetailCinemaViewController(idcinema: element.idcinema)
        })
    }
    
    func BindingtableView() {
        viewModel.dataCinema.bind(to: tableView.rx.items(cellIdentifier: "ItemCinemasTableViewCell",cellType: ItemCinemasTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
