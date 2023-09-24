//
//  Room.swift
//  CinemaBook
//
//  Created by dungtien on 9/18/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct Room: Mappable {
   var idroom = 0
    var allchair = 0
    var nameroom = ""
    var chairinrow = 0
    var statusroom = 0
    var ischeck = 0
    var dayStart = ""
    var dayEnd = ""
    
    init() {
        
    }
    
   init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        idroom <- map["idroom"]
            allchair <- map["allchair"]
            nameroom <- map["nameroom"]
            chairinrow <- map["chairinrow"]
            statusroom <- map["chairinrow"]
    }
}
