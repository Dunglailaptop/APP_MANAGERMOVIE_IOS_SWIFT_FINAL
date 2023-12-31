//
//  Utils.swift
//  myapp
//
//  Created by macmini_techres_04 on 13/06/2023.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import Photos

class Utils: NSObject {
    static func getUDID() -> String {
        let UDID = UIDevice.current.identifierForVendor!.uuidString
        return UDID.lowercased()
    }
    static func encoded(str:String) -> String{
        if let base64Str = str.base64Encoded() {
            print("Base64 encoded is string: \"\(base64Str)\"")
            return base64Str
        }
        return str
    }
    static func getAppType() -> Int{
        return 0
    }
    static func getFullMediaLink(string:String) -> String {
        dLog(("http://localhost:5062/Uploads/Movie/" + string).encodeUrl()!)
        return (urlinkimageproduction + string).encodeUrl()!
    }
    static func getCurrentDateString() -> String{
           let date = Date()
           let calendar = Calendar.current
           let components = calendar.dateComponents([.year, .month, .day], from: date)
           
           let year:Int =  components.year ?? 2022
           let month:Int = components.month ?? 01
           let day:Int = components.day ?? 01
           
           return String(format: "%02d/%02d/%d", day, month, year)
       }
    
    static func getCurrentDateStringFormatyyyyMMdd() -> String{
             let date = Date()
             let calendar = Calendar.current
             let components = calendar.dateComponents([.year, .month, .day], from: date)
             
             let year:Int =  components.year ?? 2022
             let month:Int = components.month ?? 01
             let day:Int = components.day ?? 01
             
             return String(format: "%02d-%02d-%d", year, month, day)
         }
    
    func separateDateAndTime(from dateTimeString: String) -> (date: String, time: String)? {
        // Sử dụng định dạng ngày tháng ISO 8601 để parse chuỗi thành ngày
        let isoDateFormatter = ISO8601DateFormatter()
        if let date = isoDateFormatter.date(from: dateTimeString) {
            // Định dạng lại ngày thành "yyyy-MM-dd"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            
            // Định dạng lại giờ thành "HH:mm"
            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.string(from: date)
            
            return (dateString, timeString)
        }
        return nil
    }

    
    static func getCurrentDateStringformatMysql() -> String{
              let date = Date()
              let calendar = Calendar.current
              let components = calendar.dateComponents([.year, .month, .day], from: date)
              
              let year:Int =  components.year ?? 2022
              let month:Int = components.month ?? 01
              let day:Int = components.day ?? 01
              
              return String(format: "%02d-%02d-%d", day, month, year)
          }
    
    static func getCurrentDateStringformatMysqlyymmdd() -> String{
              let date = Date()
              let calendar = Calendar.current
              let components = calendar.dateComponents([.year, .month, .day], from: date)
              
              let year:Int =  components.year ?? 2022
              let month:Int = components.month ?? 01
              let day:Int = components.day ?? 01
              
              return String(format: "%02d-%02d-%d", year, month, day)
          }
    
    func setupvideo(url:String,type:Int,view:UIView!,heights:Int) {
      
    let videoUrl = URL(string:url)
    let player = AVPlayer(url: videoUrl!)
    let playerplay = AVPlayerLayer(player: player)
    var playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//                playerplay.frame = view.bounds
        playerplay.videoGravity = .resizeAspectFill
//        playerplay.accessibilityDirectTouchOptions. = true
           if type == 0 {
              
                playerplay.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
                view.layer.addSublayer(playerplay)
                player.pause()
           } else {
               playerplay.frame = CGRect(x: 0, y: 0, width: Int(view.frame.width) + heights, height: Int(view.frame.height) + heights )
                view.layer.addSublayer(playerplay)
                player.play()
           }
               
       }
    func setupvideoyoutube(url:String,type:Int,view:UIView!) {
         
          
                    
                  
          }
    /// Lấy tên nguyên bản trên thiết bị của ảnh
       static func getImageFullName(asset: PHAsset) -> String {
           let resources = PHAssetResource.assetResources(for: asset)
           
           if let resource = resources.first {
               let fullName = resource.originalFilename
               return fullName
           }
           
           return ""
       }
   func fetchAsset(for filename: String, completion: @escaping (PHAsset?) -> Void) {
       let fetchOptions = PHFetchOptions()
       fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
       
       let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
       
       for index in 0..<fetchResult.count {
           let asset = fetchResult.object(at: index)
           if let resources = PHAssetResource.assetResources(for: asset).first,
              resources.originalFilename == filename {
               completion(asset)
               return
           }
       }
       
       completion(nil)
   }


    func getImageData(for asset: PHAsset) -> Data? {
        var imageData: Data?
        PHImageManager.default().requestImageData(for: asset, options: nil) { (data, _, _, _) in
            imageData = data
        }
        return imageData
    }
    
    
    func convertFormartDateyearMMdd(date:Date) -> String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           var dateformart = dateFormatter.string(from: date)
           return dateformart
       }
    func convertFormartDateyearMMddToString(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        // Convert the input string to a Date object
        guard let inputDate = dateFormatter.date(from: date) else {
            return nil // Return nil if the input date string is not in the expected format
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: inputDate)
        
        return formattedDate
    }

    
    func convertDateToString(inputDateString: String, inputFormat: String, outputFormat: String) -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = inputFormat
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = outputFormat
        
        if let date = dateFormatterInput.date(from: inputDateString) {
            return dateFormatterOutput.string(from: date)
        }
        
        return nil
    }
    // hàm lấy danh sách các ngày trong tuần
    func getListOfDates(startDate: Date, endDate: Date) -> [Date] {
        var currentDate = startDate
        var dates = [Date]()

        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }

        return dates
    }
    
    func getCurrentDay(date: Date) -> Int {
          let dateformat = DateFormatter()
          dateformat.dateFormat = "dd"
          
          
          let dateString = dateformat.string(from: date as Date)
          //println(dateString)
          return Int(dateString)!
      }
    func gettimenow() -> String {
        let currentTime = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "vi_VN")

        let formattedTime = dateFormatter.string(from: currentTime)
        return formattedTime
        
    }
    
   func getDayOfWeek(today: String) -> Int? {
          let formatter  = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd"
          guard let todayDate = formatter.date(from: today) else { return nil }
          let myCalendar = Calendar(identifier: .gregorian)
          let weekDay = myCalendar.component(.weekday, from: todayDate)
          return weekDay
      }
    
    func convertdatetime(string: String) -> String {
          let dateFormatterInput = DateFormatter()
          dateFormatterInput.dateFormat = "dd/MM/yyyy"

          let dateFormatterOutput = DateFormatter()
          dateFormatterOutput.dateFormat = "yyyy-MM-dd"
          let date = dateFormatterInput.date(from: string)!
              let formattedDate = dateFormatterOutput.string(from: date)
             return formattedDate
          
      }
    static func stringVietnameseMoneyFormatWithNumber(amount:Float, unit_name :String = "")->(String){
         let number = NumberFormatter()
         number.usesGroupingSeparator = true
         number.groupingSeparator = ","
         number.groupingSize = 3
         
         let strAmount = number.string(from: NSNumber(value: amount))
         return String(format: "%@ %@",strAmount!, unit_name)
     }
     
     static func stringVietnameseMoneyFormatWithNumberInt(amount:Int, unit_name :String = "")->(String){
         let number = NumberFormatter()
         number.usesGroupingSeparator = true
         number.groupingSeparator = ","
         number.groupingSize = 3
         
         let strAmount = number.string(from: NSNumber(value: amount))
         return String(format: "%@ %@",strAmount!, unit_name)
     }
     
     
     static func stringVietnameseMoneyFormatWithNumber(amount:Int)->(String){
         let number = NumberFormatter()
         number.usesGroupingSeparator = true
         number.groupingSeparator = ","
         number.groupingSize = 3
         
         let strAmount = number.string(from: NSNumber(value: amount))
         return String(format: "%@",strAmount!)
     }
     static func stringVietnameseMoneyFormatWithDouble(amount: Double)->(String){
         let number = NumberFormatter()
         number.usesGroupingSeparator = true
         number.numberStyle = .decimal
         number.groupingSeparator = ","
         number.decimalSeparator = "."
         number.groupingSize = 3
         number.maximumFractionDigits = 2
         
         let strAmount = number.string(from: NSNumber(value: amount))
         return String(format: "%@", strAmount!)
     }
     
     static func stringVietnameseMoneyFormatWithNumberDouble(amount:Double, unit_name :String = "")->(String){
         let number = NumberFormatter()
         number.usesGroupingSeparator = true
         number.numberStyle = .decimal
         number.groupingSeparator = ","
         number.decimalSeparator = "."
         number.groupingSize = 3
         number.maximumFractionDigits = 2
         
         let strAmount = number.string(from: NSNumber(value: amount))
         return String(format: "%@ %@",strAmount!, unit_name)
     }
     static func removeStringVietnameseFormatMoney(amount:String)->(Int){
         return Int(amount.replacingOccurrences(of: ",", with: "")) ?? 0
     }
     static func removeStringVietnameseFormatStringFloat(amount:String)->(Float){
         return Float(amount.replacingOccurrences(of: ",", with: "")) ?? 0
     }
     static func removeStringVietnameseFormatStringInt(amount:String)->(Double){
         return Double(amount.replacingOccurrences(of: ".", with: "")) ?? 0
     }
     
     
     static func formatQuantityToStringWithNumberFloat(quantity:Float) -> String{
         /*
             nếu 1.0 return "1"
             nếu 2.5 return "2.5"
             nếu 2.68 return "2.68"
          */
         var amount = String(format: "%.2f", quantity)
         while amount.last == "0" {
            amount.removeLast()
         }
         if amount.last == "." {
            amount.removeLast()
         }
         return amount
     }
     
     
     static func formatQuantityToStringWithNumberDouble(quantity:Double) -> String{
         /*
             nếu 1.0 return "1"
             nếu 2.5 return "2.5"
             nếu 2.68 return "2.68"
          */
         var amount = String(format: "%f", quantity)
         dLog(amount)
         while amount.last == "0" {
            amount.removeLast()
         }
         if amount.last == "." {
            amount.removeLast()
         }
         return amount
     }
     
     
     
     func capitalizeString(inputString: String) -> String {
         let capitalizedString = inputString.uppercased()
         return capitalizedString
     }

     
     
     static func stringVietnameseFormatWithNumber(amount:Int)->(String){
         let number = NumberFormatter()
         number.usesGroupingSeparator = true
         number.groupingSeparator = "."
         number.groupingSize = 3
         
         let strAmount = number.string(from: NSNumber(value: amount))
         return String(format: "%@",strAmount!)
     }
     
     static func stringQuantityFormatWithNumber(amount:Int)->(String){
         let number = NumberFormatter()
         number.usesGroupingSeparator = true
         number.groupingSeparator = ","
         number.groupingSize = 3
         
         let strAmount = number.string(from: NSNumber(value: amount))
         return String(format: "%@",strAmount!)
     }
     static func stringQuantityFormatWithNumberFloat(amount:Float)->(String){
         let number = NumberFormatter()
         number.usesGroupingSeparator = true
         number.numberStyle = .decimal
         number.groupingSeparator = ","
         number.decimalSeparator = "."
         number.groupingSize = 3
         number.maximumFractionDigits = 2
         let strAmount = number.string(from: NSNumber(value: Double(amount)))
         return String(format: "%@",strAmount!)
     }
     static func stringQuantityFormatWithNumberDouble(amount:Double)->(String){
         let number = NumberFormatter()
         number.usesGroupingSeparator = true
         number.numberStyle = .decimal
         number.groupingSeparator = ","
         number.decimalSeparator = "."
         number.groupingSize = 3
         number.maximumFractionDigits = 2
         let strAmount = number.string(from: NSNumber(value: Double(amount)))
         return String(format: "%@",strAmount!)
     }
     
     static func isCheckCharacterVN(string : String) -> Bool{
         
         let character = "àảãáạăằẳẵắặâầẩẫấậÀẢÃÁẠĂẰẲẴẮẶÂẦẨẪẤẬđĐèẻẽéẹêềểễếệÈẺẼÉẸÊỀỂỄẾỆìỉĩíịÌỈĨÍỊòỏõóọôồổỗốộơờởỡớợÒỎÕÓỌÔỒỔỖỐỘƠỜỞỠỚỢùủũúụưừửữứựÙỦŨÚỤƯỪỬỮỨỰyỳỷỹýỵỲỶỸÝỴ"
         
         if character.contains(string){
             return true
         }else{
             return false
         }
         
     }
    static func getDateString() -> (thisWeek: String, thisMonth: String, lastMonth: String, threeLastMonth: String, thisYear: String, lastYear: String, threeLastYear: String, dateTimeNow: String, today: String, yesterday: String) {
           
           let date = Date()
           let calendar = Calendar.current
           let month = calendar.component(.month, from: date)
           let year = calendar.component(.year, from: date)
           let Week = calendar.component(.weekOfYear, from: date)
           
           // Tuần này
           var thisWeek = String(format: "%d/%d", Week, year)
           if thisWeek.count == 6 {
               thisWeek = String(format: "0%d/%d", Week, year)
           }
           // Tháng này
           _ = String(format: "%d/%d", month, year)
           let tm = Calendar.current.date(byAdding: .month, value: 0, to: Date())
           let tmFormatter : DateFormatter = DateFormatter()
           tmFormatter.dateFormat = "MM/yyyy"
           let thisMonth = tmFormatter.string(from: tm!)
           
           // Tháng trước
           let lm = Calendar.current.date(byAdding: .month, value: -1, to: Date())
           let monthFormatter : DateFormatter = DateFormatter()
           monthFormatter.dateFormat = "MM/yyyy"
           let lastMonth = monthFormatter.string(from: lm!)
           
           // 3 Tháng trước
           let tlm = Calendar.current.date(byAdding: .month, value: -3, to: Date())
           let threeLastMonthFormatter : DateFormatter = DateFormatter()
           threeLastMonthFormatter.dateFormat = "MM/yyyy"
           let threeLastMonth = threeLastMonthFormatter.string(from: tlm!)
           
           // Năm nay
           let thisYear = String(year)
           
           // Năm trước
           let ly = Calendar.current.date(byAdding: .year, value: -1, to: Date())
           let yearFormatter : DateFormatter = DateFormatter()
           yearFormatter.dateFormat = "yyyy"
           let lastYear = yearFormatter.string(from: ly!)
           
           // 3 năm trước
           let tly = Calendar.current.date(byAdding: .year, value: -3, to: Date())
           let threeLastYearFormatter : DateFormatter = DateFormatter()
           threeLastYearFormatter.dateFormat = "yyyy"
           let threeLastYear = threeLastYearFormatter.string(from: tly!)
           
           // Ngày hôm nay
           let format = DateFormatter()
           format.dateFormat = "dd/MM/YYYY"
           let formattedDate = format.string(from: date)
           let dateTimeNow = formattedDate
           
           // Giờ hôm nay
           let formatTime = DateFormatter()
           formatTime.dateFormat = "HH:mm:ss"
           let today = formatTime.string(from: date)
           
           // Hôm qua
           let y = Calendar.current.date(byAdding: .day, value: -1, to: Date())
           let dateFormatter : DateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy"
           let yesterday = dateFormatter.string(from: y!)
           return (thisWeek, thisMonth, lastMonth, threeLastMonth, thisYear, lastYear, threeLastYear, dateTimeNow, today, yesterday)
       }
}
