//
//  chair.swift
//  CinemaBook
//
//  Created by dungtien on 9/10/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct chair:Mappable {
     var idchair = 0
    var numberChair = 0
    var rowChar = ""
    var bill = 0
    var statusChair = 0
    var price = 0
    var isSelected = DEACTIVE
    
    init() {
        
    }
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         idchair <- map["idchair"]
         numberChair <- map["numberChair"]
         rowChar <- map["rowChar"]
         bill <- map["bill"]
        statusChair <- map["statusChair"]
        price <- map["price"]
    }
}
