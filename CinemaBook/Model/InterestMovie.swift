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
struct InfoInterestMovie: Mappable {
      var namemovie = ""
       var  startstime = ""
        var endtime = ""
        var dateshow = ""
        var nameroom = ""
        var namecinema = ""
      var poster = ""
    var idcinema = 0
    var idinterest = 0
    var idmovie = 0
    
    init() {
        
    }
    
  init?(map: Map) {
           
       }
    
    mutating func mapping(map: Map) {
        namemovie <- map["namemovie"]
          startstime <- map["startstime"]
          endtime <- map["endtime"]
          dateshow <- map["dateshow"]
          nameroom <- map["nameroom"]
          namecinema <- map["namecinema"]
           poster <- map["poster"]
        idcinema <- map["idcinema"]
        idmovie <- map["idmovie"]
        idinterest <- map["idinterest"]
    }
}
struct Times: Mappable {
    var time = ["1:00","2:00","3:00","4:00","5:00","6:00","7:00","8:00","9:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        time <- map["time"]
    }
}
