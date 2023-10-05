//
//  Role.swift
//  CinemaBook
//
//  Created by dungtien on 9/13/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct Role: Mappable {
    var idrole = 0
    var idName = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idrole <- map["idrole"]
        idName <- map["idName"]
    }
}
