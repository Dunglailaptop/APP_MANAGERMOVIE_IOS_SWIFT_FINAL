//
//  SocketModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 29/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct numberNotifaction: Mappable {
    var numbernottifacation = 0
    var numberbill = 0
    var numberbillfood = 0
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        numbernottifacation <- map["numbernottifacation"]
        numberbill <- map["numberbill"]
        numberbillfood <- map["numberbillfood"]
    }
}

struct socketNotifcation: Mappable {
  
    var target = ""
    var arguments = [numberNotifaction]()
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
      
        target <- map["target"]
        arguments <- map["arguments"]
    }
}
struct socketBill: Mappable {
    var idbill = 0
    var tickets = [Int]()
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        idbill <- map["idbill"]
        tickets <- map["tickets"]
    }
}
struct testsocket: Mappable {
  
    var target = ""
    var arguments = [socketBill]()
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
      
        target <- map["target"]
        arguments <- map["arguments"]
    }
}
struct socketmessage: Mappable {
    var target = ""
    var arguments = [Comments]()
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
      
        target <- map["target"]
        arguments <- map["arguments"]
    }
}
