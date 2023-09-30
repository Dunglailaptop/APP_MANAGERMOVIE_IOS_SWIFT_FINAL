//
//  Food.swift
//  CinemaBook
//
//  Created by dungtien on 9/29/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import  ObjectMapper

struct FoodCombo: Mappable {
        var idcombo = 0
        var descriptions =  ""
        var nametittle =  ""
        var priceCombo = 0
        var picture = ""
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
             idcombo <- map["idcombo"]
             descriptions <- map["descriptions"]
             nametittle <- map["nametittle"]
             priceCombo <- map["priceCombo"]
             picture <- map["picture"]
    }
}


struct  Food: Mappable {
        var idfood = 0
        var namefood = "nuoc mat ong"
        var quantityfood = 0
        var picture = 0
        var pricefood = 0
        var idcategoryfood = 0
        var datecreate = ""
        var isSelected = DEACTIVE
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
            idfood <- map["idfood"]
            namefood <- map["namefood"]
            quantityfood <- map["quantityfood"]
            picture <- map["picture"]
            pricefood <- map["pricefood"]
            idcategoryfood <- map ["idcategoryfood"]
            datecreate <- map ["datecreate"]
    }
}
