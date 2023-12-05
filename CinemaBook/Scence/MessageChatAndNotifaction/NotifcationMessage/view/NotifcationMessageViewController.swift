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

class NotifcationMessageViewController: BaseViewController {

    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var viewModel = NotifcationMessageViewModel()
    var router = NotifcationMessageRouter()
    var type = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgiter()
        bindingtable()
        txt_search.rx.controlEvent(.editingChanged)
                   .withLatestFrom(txt_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       guard self != nil else { return }
                
                       let dataFirsts = viewModel.dataArraysearch.value
                       let cloneDataFilter = viewModel.dataArray.value
                       if !query!.isEmpty{
                           var filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               let str2 = value.messages.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               return str2!.contains(str1!)
                           })
                           viewModel.dataArray.accept(filteredDataArray)
                      
                       }else{
                           viewModel.dataArray.accept(dataFirsts)
                          
                          
                       }
                       
                   }).disposed(by: rxbag)
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        type = ManageCacheObject.getCurrentUserInfo().idrole == 2 ? 2:1
        viewModel.type.accept(type)
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
                    self.viewModel.dataArraysearch.accept(data)
                }
            }else
            {
                JonAlert.showError(message: "Có lỗi xảy ra trong quá trình kết nối")
            }
        })
    }
}
