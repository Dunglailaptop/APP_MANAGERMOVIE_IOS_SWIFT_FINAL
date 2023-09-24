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
    func getListMovie() {
          viewModel.getListMovieShow().subscribe(onNext: {
              (response) in
              if response.code == RRHTTPStatusCode.ok.rawValue {
                  if let data = Mapper<Movie>().mapArray(JSONObject: response.data)
                  {
                      self.viewModel.dataArrayMovie.accept(data)
                    self.getListInterest()
                  }
              }
          })
      }
    
    func getListInterest() {
        viewModel.getListInterestAutoCreate().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataMap = Mapper<InterestModel>().map(JSONObject: response.data) {
                        var dataGet = self.viewModel.pagationDataArray.value

                        dataGet.RoomLists = dataMap.list
                        dataGet.RoomLists.MovieLists = dataMap.list.MovieLists

                        self.viewModel.pagationDataArray.accept(dataGet)

                        self.spreadsheetview.reloadData()
//                        self.btn_button.isHidden = self.viewModel.pagationDataArray.value.MovieLists.count > 0 ? false:true
                }
            }
        })
    }
    
    func CreateInterest() {
        viewModel.CreateArrayInterest().subscribe(onNext: {(response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                JonAlert.showSuccess(message: "Thêm suất chiếu thành công vui lòng kiểm tra lại")
            }
            
        })
    }
    
    func getListRoom(){
           viewModel.getListRoom().subscribe(onNext: {
               (response) in
               if response.code == RRHTTPStatusCode.ok.rawValue {
                   if let data = Mapper<Room>().mapArray(JSONObject: response.data) {
                       self.viewModel.dataArrayRoom.accept(data)
                    self.getListMovie()
                   }
               }
           })
       }
    func getListAutoInterest() {
        viewModel.getListInterestAuto().subscribe(onNext: {
            (response) in
            dLog(response.toJSON())
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataMap = Mapper<InterestModel>().map(JSONObject: response.data) {
                    var dataGet = self.viewModel.pagationDataArray.value
                 
                    dataGet.RoomLists = dataMap.list
                    dataGet.RoomLists.MovieLists = dataMap.list.MovieLists
                    
                    self.viewModel.pagationDataArray.accept(dataGet)
                    dLog(self.viewModel.pagationDataArray.value)
                    self.spreadsheetview.reloadData()
                    self.btn_button.isHidden = self.viewModel.pagationDataArray.value.MovieLists.count > 0 ? false:true
                }
            }else {
                JonAlert.showError(message: "Có lỗi trong quá trình kết nối")
            }
//            if response.code == RRHTTPStatusCode.ok.rawValue {
//                if let data = Mapper<InterestModel>().map(JSONObject: response.data) {
//                    self.viewModel.dataArrayInterest.accept(data.list)
//                }
//            }
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
            cell.btn_chooseRoom.rx.tap.asDriver().drive(onNext: {[self]
                var ChooseRoom = self.viewModel.allvalue.value
                ChooseRoom.idroom = cell.data?.idroom as! Int
                self.viewModel.allvalue.accept(ChooseRoom)
                self.getListInterest()
            })
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
                 var date = viewModel.dataDay.value
                  date.DateForm = Utils().convertdatetime(string: Utils.getCurrentDateString())
                viewModel.dataDay.accept(date)
                  }else{
                       
                        lbl_dateTo.text = Utils.getCurrentDateString()
                    var date = viewModel.dataDay.value
                    date.DateTo = Utils().convertdatetime(string: Utils.getCurrentDateString())
                    viewModel.dataDay.accept(date)
                }
              
              }
        
         getListDay(startday: viewModel.dataDay.value.DateForm, endDay: viewModel.dataDay.value.DateTo)
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
        viewModel.clearData()
        var data  = viewModel.pagationDataArray.value
        Movies.enumerated().forEach{ (index,value) in
            var datas  = viewModel.pagationData.value
            dLog(Movies[index].movieID)
            datas.MovieLists.idMovie = Movies[index].movieID
            datas.MovieLists.alltime = Movies[index].timeall
            data.MovieLists.append(datas.MovieLists)
        }
        viewModel.pagationDataArray.accept(data)
        dLog(data)
//        viewModel.pagationData.accept(data)
        presentDialogPopUpListRoom()
    }
}
extension ManagementInterestMovieViewController: DialogListPopupInterestRoom {
    func callbackDialogListRoom(Rooms:Room){
        dismiss(animated: true)
        var data = viewModel.pagationDataArray.value
        data.RoomLists.idroom = Rooms.idroom
        viewModel.pagationDataArray.accept(data)
        dLog(Rooms)
        getListAutoInterest()
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
extension ManagementInterestMovieViewController {
    func presentDialogPopUpListInfoInterest(namemovie:String,imageMovie:String) {
              let PopupviewController = DialogPopupInfoListInterestMovieViewController()
        PopupviewController.viewModel = viewModel
        PopupviewController.name = namemovie
        PopupviewController.image = imageMovie
//           PopupviewController.delagate = self
              PopupviewController.view.backgroundColor = ColorUtils.blackTransparent()
              //Set up navigationBar
              let nav = UINavigationController(rootViewController: PopupviewController)
                  nav.isNavigationBarHidden = true
                  nav.modalPresentationStyle = .overCurrentContext
                    present(nav, animated: true, completion: nil)

                }
}
