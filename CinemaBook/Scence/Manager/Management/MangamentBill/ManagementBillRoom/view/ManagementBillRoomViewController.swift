//
//  ManagementBillRoomViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 04/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import ObjectMapper
import JonAlert

class ManagementBillRoomViewController: BaseViewController {

    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var viewModel = ManagementBillRoomViewModel()
    var router = ManagementBillRoomRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgiter()
        bindingtableview()
 
        txt_search.rx.controlEvent(.editingChanged)
                   .withLatestFrom(txt_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       guard self != nil else { return }
                
                       let dataFirsts = viewModel.dataArraySearch.value
                       let cloneDataFilter = viewModel.dataArray.value
                       if !query!.isEmpty{
                           var filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               let str2 = value.nameroom.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               return str2!.contains(str1!)
                           })
                           viewModel.dataArray.accept(filteredDataArray)
                      
                       }else{
                           viewModel.dataArray.accept(dataFirsts)
                          
                          
                       }
                       
                   }).disposed(by: rxbag)
        getlistRoom()
        // Do any additional setup after loading the view.
    }


 
}
extension ManagementBillRoomViewController {
    func getlistRoom() {
        viewModel.getListRoom().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Room>().mapArray(JSONObject: response.data){
                    self.viewModel.dataArray.accept(data)
                    self.viewModel.dataArraySearch.accept(data)
                }else {
                    JonAlert.showError(message: "Có lỗi xảy ra")
                }
              
            }
        })
    }
}

extension ManagementBillRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func resgiter() {
        let viewitemroom = UINib(nibName: "ItemRoomBillTableViewCell", bundle: .main)
        tableview.register(viewitemroom, forCellReuseIdentifier: "ItemRoomBillTableViewCell")
        tableview.rx.setDelegate(self)
        tableview.separatorStyle = .none
        tableview.rx.modelSelected(Room.self).subscribe(onNext: {
            element in
            self.viewModel.makeToInterestMovie(idroom: element.idroom)
        })
    }
    
    func bindingtableview() {
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "ItemRoomBillTableViewCell",cellType:ItemRoomBillTableViewCell.self)) {
            (row,data,cell) in
            cell.selectionStyle = .none
            cell.data = data
        }
    }
}
extension ManagementBillRoomViewController {

}
