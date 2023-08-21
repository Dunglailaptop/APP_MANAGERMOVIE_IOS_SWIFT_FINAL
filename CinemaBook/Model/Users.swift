//
//  Users.swift
//  CinemaBook
//
//  Created by dungtien on 8/20/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import  RxSwift
import RxCocoa
import ObjectMapper

struct Users: Mappable {
    var idusers = 0
    var fullname = ""
    var email = ""
    var phone = ""
    var birthday = ""
    var idrole = 0
    var avatar = ""
    
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idusers <- map["idusers"]
        fullname <- map["fullname"]
        email <- map["email"]
        phone <- map["phone"]
        birthday <- map["birthday"]
        idrole <- map["idrole"]
        avatar <- map["avatar"]
    }
    
}
