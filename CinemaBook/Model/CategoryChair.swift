//
//  CategoryChair.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct CategoryChair: Mappable {
    var idcategorychair = 0
    var namecategorychair = ""
    var colorchair = ""
    var price = 0
    var idroom = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         idcategorychair <- map["idcategorychair"]
           namecategorychair <- map["namecategorychair"]
           colorchair <- map["colorchair"]
           price <- map["price"]
           idroom <- map["idroom"]
    }
    
}
