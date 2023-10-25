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
                       self.viewModel.dataArrayRoomsearch.accept(data)
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let order_detail = viewModel.dataArrayRoom.value[indexPath.row]
            
            // Create a custom view with an image and label
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
            imageView.image = UIImage(named: "edit")
            imageView.contentMode = .scaleAspectFit
            imageView.center.x = customView.center.x
            
            let label = UILabel(frame: CGRect(x: 0, y: 45, width: 80, height: 30))
            label.text = "Chỉnh sửa"
            label.textAlignment = .center
            label.textColor = UIColor(hex: "34C759")
            
            customView.addSubview(imageView)
            customView.addSubview(label)
            
            // Create the swipe action using the custom view
            let cancelFood = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
//                self!.presentDialogCreateCategoryChair(TYPE: "DETAIL",idcategorys: order_detail!.idcategorychair)
                completionHandler(true)
            }
            cancelFood.backgroundColor = .UIColorFromRGB("DFEEE2")
            cancelFood.image = UIGraphicsImageRenderer(size: customView.bounds.size).image { _ in
                customView.drawHierarchy(in: customView.bounds, afterScreenUpdates: true)
            }
            
            // Configure the swipe action configuration
            let configuration = UISwipeActionsConfiguration(actions: [cancelFood])
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
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
extension ManagementRoomViewController: DialogCreateRoomInfo {
    func callbackCreateRoominfo() {
        getListRoom()
        dismiss(animated: true)
    }
    func presentDialogCreateRoom() {
            let ManagementRoomCreateViewControllers = ManagementRoomCreateViewController()
        ManagementRoomCreateViewControllers.delegate = self
        ManagementRoomCreateViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
            let nav = UINavigationController(rootViewController: ManagementRoomCreateViewControllers)
            // 1
            nav.modalPresentationStyle = .overCurrentContext
            // 2
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    
                    // 3
                    sheet.detents = [.large()]
                    
                }
            } else {
                // Fallback on earlier versions
            }
            // 4
            present(nav, animated: true, completion: nil)

        }
}
