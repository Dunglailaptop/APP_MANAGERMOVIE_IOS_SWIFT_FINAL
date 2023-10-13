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
            var foods = [FoodOfCombo]()
            var isSelected = DEACTIVE
            var quantity = 0
    var quantityRealtime = 0
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
        foods <- map["foods"]
        quantityRealtime <- map["quantityRealtime"]
    }
}

struct FoodOfCombo: Mappable {
        var idcombo = 0
        var idfood = 0
        var id = 0
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idcombo <- map["idcombo"]
        idfood <- map["idfood"]
        id <- map["id"]
    }
}

struct  Food: Mappable {
        var idfood = 0
        var namefood = "nuoc mat ong"
        var quantityfood = 0
        var picture = ""
        var pricefood = 0
        var idcategoryfood = 0
        var datecreate = ""
        var isSelected = DEACTIVE
        var idcombo = 0
        var id = 0
    var quantityRealTime = 0
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
struct CategoryFood: Mappable {
        var idcategoryfood = 0
        var namecategoryfood = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         idcategoryfood <- map["idcategoryfood"]
        namecategoryfood <- map["namecategoryfood"]
    }
}
