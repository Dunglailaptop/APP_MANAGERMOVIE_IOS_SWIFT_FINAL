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

class TimeShowViewController: BaseViewController {

    @IBOutlet weak var lbl_Cinema_Foryou: UILabel!
    @IBOutlet weak var lbl_ALL_CINAME: UILabel!
    @IBOutlet weak var calender: FSCalendar!
    var viewModel = TimeShowViewModel()
  var router = TimeShowRouter()
    var idmovie = 0
    
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
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var data = viewModel.pagation.value
        data.idmovie = idmovie
        viewModel.pagation.accept(data)
         getListInterestCinema()
          
    }

    
    @IBAction func btn_popToViewController(_ sender: Any) {
        viewModel.navigationPopToViewController()
    }
    
    
    
}
extension TimeShowViewController: FSCalendarDelegate {

    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
             // Update the selectedDateLabel with the selected date in the format "dd/MM/yyyy"
        var dateget =  Utils().convertFormartDateyearMMdd(date: date)
        var dataDate = viewModel.pagation.value
        dataDate.date = dateget
        viewModel.pagation.accept(dataDate)
      getListInterestCinema()
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
