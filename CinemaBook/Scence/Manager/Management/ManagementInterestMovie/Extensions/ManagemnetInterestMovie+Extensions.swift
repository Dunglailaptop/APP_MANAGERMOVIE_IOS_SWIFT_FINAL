//
//  ManagemnetInterestMovie+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 9/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import JonAlert
import ObjectMapper

//call api
extension ManagementInterestMovieViewController{
    func getListRoom(){
           viewModel.getListRoom().subscribe(onNext: {
               (response) in
               if response.code == RRHTTPStatusCode.ok.rawValue {
                   if let data = Mapper<Room>().mapArray(JSONObject: response.data) {
                       self.viewModel.dataArrayRoom.accept(data)
                   }
               }
           })
       }
}

extension ManagementInterestMovieViewController {
    func resgister() {
        let viewCellCollection = UINib(nibName: "ItemRoomInterestCollectionViewCell", bundle: .main)
        collectionview.register(viewCellCollection, forCellWithReuseIdentifier: "ItemRoomInterestCollectionViewCell")
        setupCollectionView()
    }
    
    func setupCollectionView() {
             let layout = UICollectionViewFlowLayout()
             layout.scrollDirection = .horizontal
             layout.itemSize = CGSize(width: 100, height: 23)
             layout.minimumLineSpacing = 5
             collectionview.collectionViewLayout = layout
             collectionview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
             collectionview.translatesAutoresizingMaskIntoConstraints = false
         }
    
    func bindingCollectionviewcell() {
        viewModel.dataArrayRoom.bind(to: collectionview.rx.items(cellIdentifier: "ItemRoomInterestCollectionViewCell", cellType: ItemRoomInterestCollectionViewCell.self))
        { (row,data,cell) in
            
            cell.data = data
            
        }
    }
}
extension ManagementInterestMovieViewController: SambagDatePickerViewControllerDelegate {
    
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult){
        if ischeckday == 0 {
           
                  self.lbl_datefrom.text = result.description
                            var date = viewModel.dataDay.value
                            date.DateForm = Utils().convertdatetime(string: result.description)
                            viewModel.dataDay.accept(date)
        }else {
          self.lbl_dateTo.text = result.description
                           var date = viewModel.dataDay.value
                           date.DateTo = Utils().convertdatetime(string: result.description)
                           viewModel.dataDay.accept(date)
          
        }
        
        let from_date = viewModel.dataDay.value.DateForm.components(separatedBy: "-")
        let to_date =  viewModel.dataDay.value.DateTo.components(separatedBy: "-")
        //
              let from_date_in = String(format: "%@%@%@", from_date[2], from_date[1], from_date[0])
              let to_date_in = String(format: "%@%@%@", to_date[2], to_date[1], to_date[0])
              dLog(from_date_in)
        dLog(to_date_in)
              // MARK: Xét điều kiện ngày bắt đầu ko được lớn hơn ngày kết thúc
              if(from_date_in > to_date_in){
                  JonAlert.show(message: "Ngày bắt đầu không được lớn hơn ngày kết thúc!", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
                  if ischeckday == 0{
                    lbl_datefrom.text = Utils.getCurrentDateString()
                 
                  }else{
                       
                        lbl_dateTo.text = Utils.getCurrentDateString()
                    
                }
              
              }
                viewController.dismiss(animated: true, completion: nil)
      
     }
     
     func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
         viewController.dismiss(animated: true, completion: nil)
     }
     
     func showDateTimePicker(dateTimeData:String){

         let vc = SambagDatePickerViewController()
         var limit = SambagSelectionLimit()
         
         var dateNow = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd/MM/yyyy"
         dateNow = dateFormatter.date(from: dateTimeData) ?? dateNow
         limit.selectedDate = dateNow

         // Set the minimum and maximum selectable dates
         let calendar = Calendar.current
         let currentDate = Date()
         let minDate = calendar.date(byAdding: .year, value: -1000, to: currentDate) // One year ago
         let maxDate = calendar.date(byAdding: .year, value: 1000, to: currentDate) // One year from now

         limit.minDate = minDate
         limit.maxDate = maxDate
         vc.limit = limit
         vc.delegate = self
         present(vc, animated: true, completion: nil)
        }
}
extension ManagementInterestMovieViewController: DialogListPopupInterestMovie {
    func presentDialogPopUpList() {
           let PopupviewController = DialogPopupListMovieViewController()
        
        PopupviewController.delagate = self
           PopupviewController.view.backgroundColor = ColorUtils.blackTransparent()
           //Set up navigationBar
           let nav = UINavigationController(rootViewController: PopupviewController)
               nav.isNavigationBarHidden = true
               nav.modalPresentationStyle = .overCurrentContext
                 present(nav, animated: true, completion: nil)

             }
    func callbackDialogListMovie(Movies:[Movie]){
        dismiss(animated: true)
        viewModel.selectedDataMovie.accept(Movies)
        presentDialogPopUpListRoom()
    }
}
extension ManagementInterestMovieViewController: DialogListPopupInterestRoom {
    func callbackDialogListRoom(Rooms:[Room]){
        dismiss(animated: true)
        viewModel.selectedDataRoom.accept(Rooms)
    }
    func presentDialogPopUpListRoom() {
             let PopupviewController = DialogPopupListRoomViewController()
          
        PopupviewController.delegate = self
             PopupviewController.view.backgroundColor = ColorUtils.blackTransparent()
             //Set up navigationBar
             let nav = UINavigationController(rootViewController: PopupviewController)
                 nav.isNavigationBarHidden = true
                 nav.modalPresentationStyle = .overCurrentContext
                   present(nav, animated: true, completion: nil)

               }
}
