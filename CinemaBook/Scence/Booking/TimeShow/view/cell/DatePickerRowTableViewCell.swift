//
//  DatePickerRowTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import FSCalendar

class DatePickerRowTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_selectedDate: UILabel!
      @IBOutlet weak var view_calender: FSCalendar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            view_calender.locale = Locale(identifier: "vi_VN")
            view_calender.scope = .week
            view_calender.delegate = self
            view_calender.dataSource = self
    }
    
}
extension DatePickerRowTableViewCell: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
           return UIColor.red // Customize the color as desired
       }
    
     func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd"
           return dateFormatter.string(from: date)
       }
       
       func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           
           let englishDayName = dateFormatter.string(from: date)
           let vietnameseDayName = convertToVietnameseDayName(englishDayName)
           
           return vietnameseDayName
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
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
          // Update the selectedDateLabel with the selected date in the format "dd/MM/yyyy"
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd/MM/yyyy"
          lbl_selectedDate.text = dateFormatter.string(from: date)
      }
}
