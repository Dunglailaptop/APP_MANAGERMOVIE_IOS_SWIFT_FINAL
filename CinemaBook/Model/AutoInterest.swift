//
//  AutoInterest.swift
//  CinemaBook
//
//  Created by dungtien on 9/19/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct InterestModel: Mappable {
    var list = RoomList()
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["list"]
    }
}



struct RoomList: Mappable {
     var idroom = 0
    var Idcinema = 0
    var MovieLists = [MovieList]()
    init() {
         
     }
     
     init(map:Map) {
         
     }
     
     mutating func mapping(map:Map) {
      idroom <- map["idroom"]
      MovieLists <- map["schedule"]
     Idcinema <- map["Idcinema"]
     }
    
}


struct MovieList: Mappable {
    var idinterest = 0
    var idMovie =  0
    var startTime = "2023-09-19T16:02:37.650Z"
    var endTime = "2023-09-19T16:02:37.650Z"
    var alltime = 0
    var image = ""
    var namemovie = ""
    var status = 0
    init() {
        
    }
    
    init(map:Map) {
        
    }
    
    mutating func mapping(map:Map) {
        idinterest <- map["idinterest"]
        idMovie <- map["idMovie"]
        startTime <- map["startTime"]
        endTime <- map["endTime"]
        alltime <- map["alltime"]
        image <- map["image"]
        namemovie <- map["namemovie"]
        status <- map["status"]
    }
}


