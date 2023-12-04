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

class ManagementBillRoomViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var viewModel = ManagementBillRoomViewModel()
    var router = ManagementBillRoomRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgiter()
        bindingtableview()
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
