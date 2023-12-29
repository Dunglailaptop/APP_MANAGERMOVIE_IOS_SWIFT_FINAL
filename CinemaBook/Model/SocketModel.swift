//
//  SocketModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 29/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct testsocket: Mappable {
  
    var target = ""
    var arguments: [[Int]] = [[]]
    
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
