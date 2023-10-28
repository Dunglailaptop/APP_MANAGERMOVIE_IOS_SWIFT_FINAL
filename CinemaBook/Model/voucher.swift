//
//  voucher.swift
//  CinemaBook
//
//  Created by dungtien on 9/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct voucher:Mappable {
   var idvoucher = 0
  var  namevoucher = ""
   var price = 0
   var percent = 0
   var note = ""
  var  poster = ""
    
    init(){}
    
    init?(map: Map) {
        
    }
    
     mutating func mapping(map: Map) {
          idvoucher <- map["idvoucher"]
            namevoucher <- map["namevoucher"]
            price <- map["price"]
            percent <- map["percent"]
            note <- map["note"]
            poster <- map["poster"]
    }
   
}
