//
//  Nation.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 21/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct Nation: Mappable {
        var idnation = 0
        var namenation = ""
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idnation <- map["idnation"]
        namenation <- map["namenation"]
    }
}
struct CategoryMovie: Mappable {
    var idcategorymovie = 0
    var namecategorymovie = ""
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idcategorymovie <- map["idcategorymovie"]
        namecategorymovie <- map["namecategorymovie"]
    }
    
}
