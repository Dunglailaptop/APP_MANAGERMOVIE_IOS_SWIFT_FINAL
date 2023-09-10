//
//  InterestMovie.swift
//  CinemaBook
//
//  Created by dungtien on 9/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct InterestMovie: Mappable {
    var namecinema = ""
    var times = ""
    var idmovie = 0
    var idcinema = 0
    var idroom = 0
    var idinterest = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         namecinema <- map["namecinema"]
            times <- map["times"]
            idmovie <- map["idmovie"]
            idcinema <- map["idcinema"]
            idroom <- map["idroom"]
            idinterest <- map["idinterest"]
    }
}