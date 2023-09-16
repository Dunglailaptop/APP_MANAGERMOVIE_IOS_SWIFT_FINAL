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
        return ("http://localhost:5062/Uploads/Movie/" + string).encodeUrl()!
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
    
    func setupvideo(url:String,type:Int,view:UIView!) {
      
           let videoUrl = URL(string:url)
                   let player = AVPlayer(url: videoUrl!)
                   let playerplay = AVPlayerLayer(player: player)
                playerplay.frame = view.bounds
           playerplay.videoGravity = .resizeAspectFill
                view.layer.addSublayer(playerplay)
           if type == 0 {
                player.pause()
           } else {
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
}
