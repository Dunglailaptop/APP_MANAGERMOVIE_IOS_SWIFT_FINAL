//
//  Trailler.swift
//  CinemaBook
//
//  Created by dungtien on 9/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct Trailler:Mappable {
 var  idvideo = 0
 var  videofile = ""
 var  iduser = 0
 var  titlevideo = ""
 var  describes = ""
 var  dateup = ""
 var  imageview = ""
 var  types = 0
  
    init() {}
    
    init?(map: Map) {
        
    }
    
     mutating func mapping(map: Map) {
           idvideo <- map["idvideo"]
            videofile <- map["videofile"]
            iduser <- map["iduser"]
            titlevideo <- map["titlevideo"]
            describes <- map["describes"]
            dateup <- map["dateup"]
            imageview <- map["imageview"]
            types <- map["types"]
    }
   
}

