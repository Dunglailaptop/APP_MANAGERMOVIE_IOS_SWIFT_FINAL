//
//  ManagementInterestMoviesViewController + Extension.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 17/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import JonAlert

extension ManagementInterestMoviesViewController {
    func presentDialogDetailMovieInterest(movies:MovieList) {
        let DialogPopupInfoListInterestMovieViewControllers = DialogPopupInfoListInterestMovieViewController()
        DialogPopupInfoListInterestMovieViewControllers.nameroom = viewModel.pagationDataArray.value.Rooms.nameroom
        DialogPopupInfoListInterestMovieViewControllers.movie = movies
        DialogPopupInfoListInterestMovieViewControllers.viewModel = self.viewModel
        DialogPopupInfoListInterestMovieViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: DialogPopupInfoListInterestMovieViewControllers)
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

extension ManagementInterestMoviesViewController: CaculatorInputQuantityDelegate {
    func presentModalInputQuantityViewController(position:Int, current_quantity:Float) {
        let quantityInputViewController = QuantityInputViewController()
        
        quantityInputViewController.current_quantity = current_quantity
        quantityInputViewController.max_quantity = 30
        quantityInputViewController.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: quantityInputViewController)
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
        quantityInputViewController.delegate_quantity = self
        quantityInputViewController.position = position
            present(nav, animated: true, completion: nil)

        }
    func callbackCaculatorInputQuantity(number: Float, position: Int) {
        let roundedNumber = round(number)
           lbl_number_txt.text = String(Int(roundedNumber)) + " phút"
        var allvalue = viewModel.allvalue.value
        allvalue.breakTime = Int(roundedNumber)
        viewModel.allvalue.accept(allvalue)
        dLog(viewModel.allvalue.value)
       
    }
}

extension ManagementInterestMoviesViewController: DialogUpdateSatusInterest {
    func callbackUpdatesatusInterest(idinterest: Int, status: Int) {
        var allvalues = viewModel.allvalue.value
        allvalues.idinterest = idinterest
        allvalues.statusInterest = status
        viewModel.allvalue.accept(allvalues)
        self.UpdateSatus()
        dismiss(animated: true)
    }
    
    func presentDialogAccessUpdateSatus(idinterest:Int,status:Int) {
            let DialogAccessUpdatesatusInterestViewControllers = DialogAccessUpdatesatusInterestViewController()
        DialogAccessUpdatesatusInterestViewControllers.idinterest = idinterest
        DialogAccessUpdatesatusInterestViewControllers.status = status
        if status == 1 {
            DialogAccessUpdatesatusInterestViewControllers.tittle = "Bạn có muốn mở khoá suất chiếu"
        }else {
            DialogAccessUpdatesatusInterestViewControllers.tittle = "Bạn có muốn khoá suất chiếu"
        }
        DialogAccessUpdatesatusInterestViewControllers.delegate = self
        DialogAccessUpdatesatusInterestViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
            let nav = UINavigationController(rootViewController: DialogAccessUpdatesatusInterestViewControllers)
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

extension ManagementInterestMoviesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return viewModel.dataArray.value.count
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let order_detail = viewModel.movielist.value[indexPath.row]
            
        // Create a custom view with an image and label
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
        imageView.image = UIImage(named: "edit.png")
        imageView.contentMode = .scaleAspectFit
        imageView.center.x = customView.center.x
        
        let label = UILabel(frame: CGRect(x: 0, y: 45, width: 80, height: 30))
        label.text = "Chỉnh sửa"
        label.textAlignment = .center
        label.textColor = .white
        
        customView.addSubview(imageView)
        customView.addSubview(label)
        
        // Create a custom view with an image and label
        let customView2 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
        imageView2.image = UIImage(named: "delete")
        imageView2.contentMode = .scaleAspectFit
        imageView2.center.x = customView2.center.x
        
        let label2 = UILabel(frame: CGRect(x: 0, y: 45, width: 80, height: 30))
        label2.text = "Huỷ suất"
        label2.textAlignment = .center
        label2.textColor = .white
        
        customView2.addSubview(imageView2)
        customView2.addSubview(label2)
        
        // mo khoa suat chieu
        // Create a custom view with an image and label
        let customView3 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        let imageView3 = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
        imageView3.image = UIImage(named: "delete")
        imageView3.contentMode = .scaleAspectFit
        imageView3.center.x = customView3.center.x
        
        let label3 = UILabel(frame: CGRect(x: 0, y: 45, width: 80, height: 30))
        label3.text = "Mở khoá"
        label3.textAlignment = .center
        label3.textColor = .white
        
        customView3.addSubview(imageView3)
        customView3.addSubview(label3)
      
        // Create the first swipe action using the custom view
           let cancelFood = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
               dLog(order_detail)
               self!.presentDialogAccessUpdateSatus(idinterest: order_detail.idinterest, status: 1)
               completionHandler(true)
           }
        cancelFood.backgroundColor = .red
           cancelFood.image = UIGraphicsImageRenderer(size: customView2.bounds.size).image { _ in
               customView2.drawHierarchy(in: customView2.bounds, afterScreenUpdates: true)
           }
           
           // Create a second swipe action (similar to the first one)
           let secondAction = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
               self!.presentDialogDetailMovieInterest(movies: order_detail)
               completionHandler(true)
           }
        secondAction.backgroundColor = .systemGreen
           secondAction.image = UIGraphicsImageRenderer(size: customView.bounds.size).image { _ in
               customView.drawHierarchy(in: customView.bounds, afterScreenUpdates: true)
           }
        
        // Create a second swipe action (similar to the first one)
        let actionUpdateUnlock = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
            self!.presentDialogAccessUpdateSatus(idinterest: order_detail.idinterest, status: 0)
            completionHandler(true)
        }
        actionUpdateUnlock.backgroundColor = .blue
        actionUpdateUnlock.image = UIGraphicsImageRenderer(size: customView3.bounds.size).image { _ in
            customView3.drawHierarchy(in: customView3.bounds, afterScreenUpdates: true)
        }
           
        
        if order_detail.status == 1 {
            // Configure the swipe action configuration
            let configuration = UISwipeActionsConfiguration(actions: [actionUpdateUnlock])
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
        }else {
            // Configure the swipe action configuration
            let configuration = UISwipeActionsConfiguration(actions: [cancelFood, secondAction])
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
        }
          
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func register() {
        let cellview = UINib(nibName: "ManagementInterestMoviesTableViewCell", bundle: .main)
        tableView.register(cellview, forCellReuseIdentifier: "ManagementInterestMoviesTableViewCell")
       
        tableView.delegate = self
    }
    

    
    
    func bindingtable() {
        viewModel.movielist.bind(to: tableView.rx.items(cellIdentifier: "ManagementInterestMoviesTableViewCell", cellType: ManagementInterestMoviesTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
    
    
}
extension ManagementInterestMoviesViewController {
    func getListRoom(){
           viewModel.getListRoom().subscribe(onNext: {
               (response) in
               if response.code == RRHTTPStatusCode.ok.rawValue {
                   if let data = Mapper<Room>().mapArray(JSONObject: response.data) {
                       self.viewModel.dataArrayRoom.accept(data)
                       self.dropdown.optionArray = data.map({$0.nameroom})
                       self.dropdown.optionIds = data.map({$0.idroom})
                       self.getListMovie()
                   }
               }
           })
       }
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
                    dLog(self.viewModel.pagationDataArray.value)
                    self.viewModel.movielist.accept(self.viewModel.pagationDataArray.value.RoomLists.MovieLists)
                    self.lbl_number.text = String(self.viewModel.movielist.value.count)
                    self.view_no_data.isHidden = self.viewModel.movielist.value.count > 0 ? true : false
                    var dataNumberTimeReset = self.viewModel.movielist.value
                    dataNumberTimeReset.enumerated().forEach{
                        (index,value) in
                        dLog(value.resetTime)
                      
                        self.lbl_number_txt.text = String(value.resetTime)
                        
                     
                       
                    }
//                    self.viewModel.movielist.accept(dataGet.MovieLists)
                }
            }
        })
    }
    
    func CreateInterest() {
        viewModel.CreateArrayInterest().subscribe(onNext: {(response) in
            dLog(response.code)
            if response.code == RRHTTPStatusCode.ok.rawValue {
                JonAlert.showSuccess(message: "Thêm suất chiếu thành công vui lòng kiểm tra lại")
                self.getListInterest()
            }
            
        })
    }
    func UpdateSatus() {
        viewModel.updateSatusInterest().subscribe(onNext: {(response) in
            dLog(response.code)
            if response.code == RRHTTPStatusCode.ok.rawValue {
                JonAlert.showSuccess(message: "Huỷ suất chiếu thành công")
                self.getListInterest()
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
                    dataGet.RoomLists.Idcinema = ManageCacheObject.getCurrentCinema().idcinema
                    self.viewModel.pagationDataArray.accept(dataGet)
                    var dataPagtionDataArray = self.viewModel.pagationDataArray.value
//                    self.viewModel.movielist.accept(dataPagtionDataArray.RoomLists.MovieLists)
                    dLog(dataGet)
                    self.lbl_number.text = String(self.viewModel.movielist.value.count)
                    dLog(self.viewModel.movielist.value)
                    dLog(self.viewModel.pagationDataArray.value)
                   
                    self.tableView.reloadData()
                    self.CreateInterest()
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
extension ManagementInterestMoviesViewController: DialogListPopupInterestMovie {
    func presentDialogPopUpList(date:String) {
                let PopupviewController = DialogPopupListMovieViewController()
                dLog(viewModel.pagationDataArray.value.RoomLists.idroom)
                PopupviewController.delagate = self
                PopupviewController.date = date
                PopupviewController.idroom = viewModel.pagationDataArray.value.RoomLists.idroom
        PopupviewController.nameroom = viewModel.pagationDataArray.value.Rooms.nameroom
        dLog(viewModel.pagationDataArray.value.RoomLists)
                PopupviewController.view.backgroundColor = ColorUtils.blackTransparent()
                //Set up navigationBar
                let nav = UINavigationController(rootViewController: PopupviewController)
                nav.isNavigationBarHidden = true
                nav.modalPresentationStyle = .overCurrentContext
                present(nav, animated: true, completion: nil)

             }
    func callbackDialogListMovie(Movies:[Movie],date:String,idroom:Int,nameroom:String){
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
      
        data.RoomLists.idroom = idroom
        data.RoomLists.Idcinema = ManageCacheObject.getCurrentCinema().idcinema
        viewModel.pagationDataArray.accept(data)
        viewModel.dataArrayMovie.accept(Movies)
        presentDialogPopUpListRoom(date: date, idroom: idroom,Movies: Movies,nameroom: nameroom)
//        getListAutoInterest()
    }
}
extension ManagementInterestMoviesViewController: DialogListPopupInterestRoom {
    func callbackDialogListRoom(idroom:Int,date:String){
        var dataday = viewModel.dataDay.value
        dataday.DateForm = date
        dataday.DateTo = date
        viewModel.dataDay.accept(dataday)
        getListAutoInterest()
        dismiss(animated: true)
    
    }
    func presentDialogPopUpListRoom(date:String,idroom:Int,Movies:[Movie],nameroom:String) {
            let PopupviewController = DialogPopupListRoomViewController()
        PopupviewController.viewModel = self.viewModel
            PopupviewController.Movies = Movies
            PopupviewController.delegate = self
            PopupviewController.date = date
        PopupviewController.nameroom = nameroom
            PopupviewController.view.backgroundColor = ColorUtils.blackTransparent()
            //Set up navigationBar
            let nav = UINavigationController(rootViewController: PopupviewController)
            nav.isNavigationBarHidden = true
            nav.modalPresentationStyle = .overCurrentContext
            present(nav, animated: true, completion: nil)

               }
}
extension ManagementInterestMoviesViewController {

}
