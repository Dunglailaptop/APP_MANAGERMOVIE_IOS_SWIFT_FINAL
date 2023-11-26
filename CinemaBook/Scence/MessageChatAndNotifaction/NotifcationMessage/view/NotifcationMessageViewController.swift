//
//  NotifcationMessageViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 06/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import JonAlert

class NotifcationMessageViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var viewModel = NotifcationMessageViewModel()
    var router = NotifcationMessageRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgiter()
        bindingtable()
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotication()
    }
    

  

}
extension NotifcationMessageViewController: UITableViewDelegate {
    func resgiter() {
        let itemmessage = UINib(nibName: "ItemNoTiFactionTableViewCell", bundle: .main)
        tableview.register(itemmessage, forCellReuseIdentifier: "ItemNoTiFactionTableViewCell")
        tableview.rx.setDelegate(self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func bindingtable() {
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier:"ItemNoTiFactionTableViewCell" ,cellType: ItemNoTiFactionTableViewCell.self))
        {
            (row,data,cell) in
            cell.data = data
        }
     }
    
    func getNotication() {
        viewModel.getNotiCationMessage().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<notifaction>().mapArray(JSONObject: response.data)
                {
                    self.viewModel.dataArray.accept(data)
                }
            }else
            {
                JonAlert.showError(message: "Có lỗi xảy ra trong quá trình kết nối")
            }
        })
    }
}
