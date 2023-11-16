//
//  ListMovieShowNowViewController+Extension.swift
//  CinemaBook
//
//  Created by dungtien on 8/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift
import ObjectMapper
import JonAlert

extension ListMovieShowNowViewController: SambagDatePickerViewControllerDelegate {
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult) {
          dLog(result.description)
        var data = viewModel.allvalue.value
        if(type_choose_date == 0) {
            data.dateFrom = Utils().convertFormartDateyearMMddToString(date: result.description)!
            lbl_date_From.text = result.description
           
        } else {
          
            data.dateTo = Utils().convertFormartDateyearMMddToString(date: result.description)!
            lbl_date_to.text = result.description
        }
        viewModel.allvalue.accept(data)
        dLog(viewModel.allvalue.value)
        let from_date = viewModel.allvalue.value.dateFrom.components(separatedBy: "-")
        let to_date = viewModel.allvalue.value.dateTo.components(separatedBy: "-")
    
        let from_date_in = String(format: "%@%@%@", from_date[2], from_date[1], from_date[0])
        let to_date_in = String(format: "%@%@%@", to_date[2], to_date[1], to_date[0])
        
        // MARK: Xét điều kiện ngày bắt đầu ko được lớn hơn ngày kết thúc
        dLog(from_date_in)
        dLog(to_date_in)
        if(from_date_in > to_date_in){
            JonAlert.show(message: "Ngày bắt đầu không được lớn hơn ngày kết thúc!", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
            if(type_choose_date == 0){
                lbl_date_to.text = Utils.getCurrentDateString()
                lbl_date_From.text = Utils.getCurrentDateString()
                var datadate = viewModel.allvalue.value
                datadate.dateFrom = Utils.getCurrentDateStringformatMysqlyymmdd()
                datadate.dateTo = Utils.getCurrentDateStringformatMysqlyymmdd()
            }else{
                lbl_date_to.text = Utils.getCurrentDateString()
                lbl_date_From.text = Utils.getCurrentDateString()
                var datadate = viewModel.allvalue.value
                datadate.dateFrom = Utils.getCurrentDateStringformatMysqlyymmdd()
                datadate.dateTo = Utils.getCurrentDateStringformatMysqlyymmdd()
             
            }
        }
        getListmovie()
          viewController.dismiss(animated: true, completion: nil)
      }

      func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
          viewController.dismiss(animated: true, completion: nil)
      }

      func showDateTimePicker(dataDateTime : String){
          let vc = SambagDatePickerViewController()
          var limit = SambagSelectionLimit()
          var dateNow = Date()
          let dateString = dataDateTime
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd/MM/yyyy"
          dateNow = dateFormatter.date(from: dateString)!
          limit.selectedDate = dateNow
          
          let currentDate = Date()
          let minDate = Calendar.current.date(byAdding: .year, value: -1000, to: currentDate)
          let maxDate = Calendar.current.date(byAdding: .year, value: 1000, to: currentDate)
          
          limit.minDate = minDate
          limit.maxDate = maxDate
          vc.limit = limit
          vc.delegate = self
          present(vc, animated: true, completion: nil)
      }
}

extension ListMovieShowNowViewController{
    func resgisterCollection(){
        let bannertableviewcell = UINib(nibName: "itemMovieTableViewCell", bundle: .main)
        tableView.register(bannertableviewcell, forCellReuseIdentifier: "itemMovieTableViewCell")
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
    }



    func binđDataTableCollectionView(){
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "itemMovieTableViewCell", cellType: itemMovieTableViewCell.self)) { (index, data, cell) in
            cell.data = data
            cell.viewModel = self.viewModel
            switch self.type_viewTralling {
            case 1:
                if cell.data?.statusshow == 1 {
                    cell.view_trallsing_edit.backgroundColor = .red
                }else {
                    cell.view_trallsing_edit.backgroundColor = .green
                }
                cell.view_trallsing_edit.isHidden = false
            default:
                cell.view_trallsing_edit.isHidden = true
            }
          
       

            }.disposed(by: rxbag)
    }

}

// CALL API
extension ListMovieShowNowViewController {
    
    func getListMovieBooking() {
        viewModel.getListMovieBooking().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Movie>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                    self.viewModel.dataSearch.accept(data)
                    self.view_no_data.isHidden = self.viewModel.dataArray.value.count > 0 ? true:false
                }
            }
        }).disposed(by: rxbag)
    }
    
    
    func getListCategoryMovie() {
        
    }
    
    func getListmovie() {
        viewModel.getListMovieShow().subscribe(onNext: { (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                if let movies = Mapper<Movie>().mapArray(JSONObject: response.data)
                {
                 
                    self.viewModel.dataArray.accept(movies)
                    self.viewModel.dataSearch.accept(movies)
                    self.view_no_data.isHidden = self.viewModel.dataArray.value.count > 0 ? true: false
                }
            }

            }).disposed(by: rxbag)
    }

    func updateSatusMovie() {
        viewModel.UpdateStatusMovie().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                self.getListmovie()
            }
        })
    }

}

extension ListMovieShowNowViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let movie_detail = viewModel.dataArray.value[indexPath.row]
            
            // Create a custom view with an image and label
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
            imageView.image = UIImage(named: "icon-check-white")
            imageView.contentMode = .scaleAspectFit
            imageView.center.x = customView.center.x
            
            let label = UILabel(frame: CGRect(x: 0, y: 45, width: 80, height: 30))
            label.text = "DUYỆT"
            label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
            customView.addSubview(imageView)
            customView.addSubview(label)
            // huy
        // Create a custom view with an image and label
        let customView2 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
        imageView2.image = UIImage(named: "icon-delete-white")
        imageView2.contentMode = .scaleAspectFit
        imageView2.center.x = customView2.center.x
        
        let label2 = UILabel(frame: CGRect(x: 0, y: 45, width: 80, height: 30))
        label2.text = "HUỶ BỎ"
        label2.textAlignment = .center
        label2.textColor = .white
        label2.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        customView2.addSubview(imageView2)
        customView2.addSubview(label2)
        // close movie
        let customView3 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        let imageView3 = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
        imageView3.image = UIImage(named: "icon-delete-white")
        imageView3.contentMode = .scaleAspectFit
        imageView3.center.x = customView3.center.x
        
        let label3 = UILabel(frame: CGRect(x: 0, y: 45, width: 80, height: 30))
        label3.text = "NGƯNG"
        label3.textAlignment = .center
        label3.textColor = .white
        label3.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        customView3.addSubview(imageView3)
        customView3.addSubview(label3)
        //open
        let customView4 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        let imageView4 = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
        imageView4.image = UIImage(named: "icon-check-white")
        imageView4.contentMode = .scaleAspectFit
        imageView4.center.x = customView4.center.x
        
        let label4 = UILabel(frame: CGRect(x: 0, y: 45, width: 80, height: 30))
        label4.text = "MỞ LẠI"
        label4.textAlignment = .center
        label4.textColor = .white
        label4.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        customView4.addSubview(imageView4)
        customView4.addSubview(label4)
            // Create the swipe action using the custom view
            let cancelFood = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
                var dataMovie = self!.viewModel.dataMovie.value
                dataMovie.movieID = movie_detail.movieID
                dataMovie.statusshow = 1
                self!.viewModel.dataMovie.accept(dataMovie)
                self!.updateSatusMovie()
            
                completionHandler(true)
            }
            cancelFood.backgroundColor = .green
            cancelFood.image = UIGraphicsImageRenderer(size: customView.bounds.size).image { _ in
                customView.drawHierarchy(in: customView.bounds, afterScreenUpdates: true)
            }
            
        // Create the swipe action using the custom view
        let deleteMovie = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
            var dataMovie = self!.viewModel.dataMovie.value
            dataMovie.movieID = movie_detail.movieID
            dataMovie.statusshow = -1
            self!.viewModel.dataMovie.accept(dataMovie)
            self!.updateSatusMovie()
            completionHandler(true)
        }
        deleteMovie.backgroundColor = .red
        deleteMovie.image = UIGraphicsImageRenderer(size: customView2.bounds.size).image { _ in
            customView2.drawHierarchy(in: customView2.bounds, afterScreenUpdates: true)
        }
        //
        let closemovie = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
            var dataMovie = self!.viewModel.dataMovie.value
            dataMovie.movieID = movie_detail.movieID
            dataMovie.statusshow = 3
            self!.viewModel.dataMovie.accept(dataMovie)
            self!.updateSatusMovie()
            completionHandler(true)
        }
        closemovie.backgroundColor = .red
        closemovie.image = UIGraphicsImageRenderer(size: customView3.bounds.size).image { _ in
            customView3.drawHierarchy(in: customView3.bounds, afterScreenUpdates: true)
        }
        //Open
        let openMovie = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
            var dataMovie = self!.viewModel.dataMovie.value
            dataMovie.movieID = movie_detail.movieID
            dataMovie.statusshow = 1
            self!.viewModel.dataMovie.accept(dataMovie)
            self!.updateSatusMovie()
            completionHandler(true)
        }
        openMovie.backgroundColor = .green
        openMovie.image = UIGraphicsImageRenderer(size: customView4.bounds.size).image { _ in
            customView4.drawHierarchy(in: customView4.bounds, afterScreenUpdates: true)
        }
        
        switch Type_edit {
        case 1:
            // Configure the swipe action configuration
            let configuration = UISwipeActionsConfiguration(actions: [deleteMovie,cancelFood])
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
        case 2:
            if movie_detail.statusshow == 1 {
                // Configure the swipe action configuration
                let configuration = UISwipeActionsConfiguration(actions: [closemovie])
                configuration.performsFirstActionWithFullSwipe = false
                
                return configuration
            }else if movie_detail.statusshow == 3
            {
                // Configure the swipe action configuration
                let configuration = UISwipeActionsConfiguration(actions: [openMovie])
                configuration.performsFirstActionWithFullSwipe = false
                
                return configuration
            } else {
                // Configure the swipe action configuration
                let configuration = UISwipeActionsConfiguration(actions: [])
                configuration.performsFirstActionWithFullSwipe = false
                
                return configuration
            }
          
        default:
            // Configure the swipe action configuration
            let configuration = UISwipeActionsConfiguration(actions: [])
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
        }
           
          
    }
}


