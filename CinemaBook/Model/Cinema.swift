//
//  Cinema.swift
//  CinemaBook
//
//  Created by dungtien on 9/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct  Cinema:Mappable {
   var idcinema = 0
  var  namecinema = ""
  var  address = ""
  var  phone = ""
  var  picture  = ""
  var  describes = ""
  var   rooms = ""
  var  userofcinemas = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         idcinema <- map["idcinema"]
          namecinema <- map["namecinema"]
          address <- map["address"]
          phone <- map["phone"]
          picture  <- map["picture"]
          describes <- map["describes"]
           rooms <- map["rooms"]
          userofcinemas <- map["userofcinemas"]
    }
}
