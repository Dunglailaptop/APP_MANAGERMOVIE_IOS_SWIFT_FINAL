//
//  Notifaction.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import ObjectMapper

struct notifaction: Mappable {
        var idnotifaction = 0
        var messages = ""
        var datecreate = ""
        var iduser = 0
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idnotifaction <- map["idnotifaction"]
        messages <- map["messages"]
        datecreate <- map["datecreate"]
        iduser <- map["iduser"]
    }
    
}
