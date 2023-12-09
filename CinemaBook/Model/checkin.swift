//
//  checkin.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct checkin: Mappable {
    var idcheckin = 0
     var timestart = ""
     var timeend = ""
     var idusers = 0
     var checksession = 0
     var idcinema = 0
    
    init?(map: Map) {
        
    }
    
    init() {}
    
    mutating func mapping(map: Map) {
         idcheckin <- map["idcheckin"]
         timestart <- map["timestart"]
         timeend <- map["timeend"]
         idusers <- map["idusers"]
         checksession <- map["checksession"]
         idcinema <- map["idcinema"]
    }
}
