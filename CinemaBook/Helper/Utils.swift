//
//  Utils.swift
//  myapp
//
//  Created by macmini_techres_04 on 13/06/2023.
//

import Foundation
import UIKit

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
        dLog(("http://localhost:5062/" + string).encodeUrl()!)
        return ("http://localhost:5062/" + string).encodeUrl()!
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
}
