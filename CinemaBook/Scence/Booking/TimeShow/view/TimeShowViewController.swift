//
//  TimeShowViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/27/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import QVRWeekView
import FSCalendar
import JonAlert

class TimeShowViewController: BaseViewController {

    @IBOutlet weak var view_no_data: UIView!
    @IBOutlet weak var lbl_name_movie: UILabel!
    @IBOutlet weak var lbl_Cinema_Foryou: UILabel!
    @IBOutlet weak var lbl_ALL_CINAME: UILabel!
    @IBOutlet weak var calender: FSCalendar!
    var viewModel = TimeShowViewModel()
  var router = TimeShowRouter()
    var idmovie = 0
    var idroom = 0
    var namemovie = ""
    var check = false
    var checkbillroom = false
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
          register()
        bindingtableviewcell()
       
       setup()
    // Điều chỉnh chiều cao của phần header (tháng và năm)
    
    }
    
    
    
    func setup() {
            calender.scope = .week
            FSCalendar.appearance().rowHeight = 100
            calender.backgroundColor = .darkGray
            calender.locale = Locale(identifier: "vi_VN")
            calender.delegate = self
            lbl_name_movie.text = namemovie
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var data = viewModel.pagation.value
        if idroom == 0 {
            data.idmovie = idmovie
            viewModel.pagation.accept(data)
            getListInterestCinema()
            checkbillroom = true
        } else {
            data.idroom = idroom
            viewModel.pagation.accept(data)
            getListInterestRoom()
            checkbillroom = false
        }
       
       
          
    }

    
    @IBAction func btn_popToViewController(_ sender: Any) {
        viewModel.navigationPopToViewController()
    }
    
    
    
}
extension TimeShowViewController: FSCalendarDelegate {

    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        var dateget =  Utils().convertFormartDateyearMMdd(date: date)
        var dataDate = viewModel.pagation.value
        dataDate.date = dateget
        viewModel.pagation.accept(dataDate)
       
        
        let currentDate = Utils.getCurrentDateString().components(separatedBy: "/")
          let chosenDate = Utils().convertFormartDateyearMMdd(date: date).components(separatedBy: "-")
          var datechoose = chosenDate[0] + chosenDate[1] + chosenDate[2]
        var datenow = currentDate[2] + currentDate[1] + currentDate[0]
          dLog(datechoose + "-" + datenow)
        if checkbillroom{
          if datechoose < datenow {
              JonAlert.showSuccess(message: "Ngày hiện tại không tồn tại suất chiếu")
              view_no_data.isHidden = false
           
          }else {
          
                
              getListInterestCinema()
          }
        }else {
            getListInterestRoom()
           
        }
       
        
    }
    func convertToVietnameseDayName(_ englishDayName: String) -> String {
             switch englishDayName {
                 case "Monday":
                     return "Thứ Hai"
                 case "Tuesday":
                     return "Thứ Ba"
                 case "Wednesday":
                     return "Thứ Tư"
                 case "Thursday":
                     return "Thứ Năm"
                 case "Friday":
                     return "Thứ Sáu"
                 case "Saturday":
                     return "Thứ Bảy"
                 case "Sunday":
                     return "Chủ Nhật"
                 default:
                     return ""
             }
         }
   
}
