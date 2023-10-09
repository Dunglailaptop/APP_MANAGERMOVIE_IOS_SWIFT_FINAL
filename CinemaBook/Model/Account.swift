//
//  Account.swift
//  CinemaBook
//
//  Created by dungtien on 7/23/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import ObjectMapper

struct Account: Mappable{
    var id = 0
    var username = ""
    var password = ""
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        password <- map["password"]
    }
}
