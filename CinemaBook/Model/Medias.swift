//
//  Medias.swift
//  CinemaBook
//
//  Created by dungtien on 9/3/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import AVKit
import ObjectMapper

struct Medias:Mappable {
    var name: String?
    var image: UIImage?
    
    init?(map: Map) {
        
    }
    
    init() {
        
    }
   
    mutating func mapping(map: Map) {
        name <- map["name"]
        image <- map["file"]
    }

}
