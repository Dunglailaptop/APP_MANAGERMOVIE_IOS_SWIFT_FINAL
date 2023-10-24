//
//  ManagementRoomViewController+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

extension ManagementRoomViewController {
       func getListRoom(){
           viewModel.getListRoom().subscribe(onNext: {
               (response) in
               if response.code == RRHTTPStatusCode.ok.rawValue {
                   if let data = Mapper<Room>().mapArray(JSONObject: response.data) {
                       self.viewModel.dataArrayRoom.accept(data)
                    self.getListCategoryChair()
                   }
               }
           })
       }
    
    func getListCategoryChair() {
        viewModel.getListCategoryChair().subscribe(onNext: {
                      (response) in
                      if response.code == RRHTTPStatusCode.ok.rawValue {
                          if let data = Mapper<CategoryChair>().mapArray(JSONObject: response.data) {
                              self.viewModel.dataArrayCategoryChair.accept(data)
                         
                          }
                      }
                  })
    }
    
    func getListchairRoom() {
          viewModel.getListchairRoom().subscribe(onNext: {
              (response) in
              if response.code == RRHTTPStatusCode.ok.rawValue {
                  if let data = Mapper<chair>().mapArray(JSONObject: response.data) {
                      self.viewModel.dataArrayChair.accept(data)
                  }
              }
              }).disposed(by: rxbag)
      }

}

extension ManagementRoomViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func register() {
        let celltable = UINib(nibName: "ItemRoomTableViewCell", bundle: .main)
        tableView.register(celltable, forCellReuseIdentifier: "ItemRoomTableViewCell")
        tableView.rx.setDelegate(self)
        tableView.separatorStyle = .none
        tableView.rx.modelSelected(Room.self).subscribe(onNext: {
            element in
            self.viewModel.makeToManagementDetailViewController(room: element)
        })
    }
    func bindingCollectionCell() {
        viewModel.dataArrayRoom.bind(to: tableView.rx.items(cellIdentifier: "ItemRoomTableViewCell", cellType: ItemRoomTableViewCell.self)) {
            (row,data,cell) in
             cell.data = data
            cell.selectionStyle = .none
//            cell.btn_choose_room.rx.tap.asDriver().drive(onNext: {
//                let Response = ["userInfo": cell.data?.idroom]
//                   NotificationCenter.default.post(name: Notification.Name("NotificationCallApi"), object: nil,userInfo: Response)
//
//            }).disposed(by: self.rxbag)
        }
    }

 
   
}
