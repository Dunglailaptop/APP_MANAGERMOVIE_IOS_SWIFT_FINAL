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
    var list = [AutoInterest]()
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["list"]
    }
}

struct AutoInterest: Mappable {
   var idroom = 0
    var schedule = [scheduleMovie]()
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        idroom <- map["idroom"]
        schedule <- map["schedule"]
    }
}

struct scheduleMovie: Mappable {
    var idMovie = 0
    var startTime =  ""
    var endTime = ""
    var alltime = ""
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idMovie <- map["idMovie"]
        startTime <- map["startTime"]
        endTime <- map["endTime"]
        alltime <- map["alltime"]
        
    }
}

struct MovieList: Mappable {
    var idMovie =  0
    var startTime = "2023-09-19T16:02:37.650Z"
    var endTime = "2023-09-19T16:02:37.650Z"
    var alltime = 0
    
    init() {
        
    }
    
    init(map:Map) {
        
    }
    
    mutating func mapping(map:Map) {
        idMovie <- map["idMovie"]
        startTime <- map["startTime"]
        endTime <- map["endTime"]
        alltime <- map["alltime"]
    }
}

struct RoomList: Mappable {
     var idroom = 0
    init() {
         
     }
     
     init(map:Map) {
         
     }
     
     mutating func mapping(map:Map) {
      idroom <- map["idroom"]
     }
    
}
