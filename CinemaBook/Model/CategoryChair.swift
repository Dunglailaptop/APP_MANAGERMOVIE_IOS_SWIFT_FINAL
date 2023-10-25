//
//  CategoryChair.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct CategoryChair: Mappable {
    var idcategorychair = 0
   var  idcategoryChair = 0 // id cap nhat
    var namecategorychair = ""
    var namecategory = ""
    var colorchair = ""
    var price = 0
    var idroom = 0
    var nameroom = ""
    init(){
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idcategoryChair <- map["idcategoryChair"]
         idcategorychair <- map["idcategorychair"]
           namecategorychair <- map["namecategorychair"]
        namecategory <- map["namecategory"]
           colorchair <- map["colorchair"]
           price <- map["price"]
           idroom <- map["idroom"]
        nameroom <- map["nameroom"]
    }
    
}
//struct categoryinfoDetail: Mappable {
//    var idcategorychair = 0
//        var price = 0
//        var namecategory = ""
//        var colorchair = ""
//        var idroom = 0
//        var nameroom = ""
//    init() {
//
//    }
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//        idcategorychair <- map["idcategorychair"]
//         price <- map["price"]
//         namecategory <- map["namecategory"]
//         colorchair <- map["colorchair"]
//         idroom <- map["idroom"]
//         nameroom <- map["nameroom"]
//    }
//}
//model cap nhat danh sach ghe theo danh muc ghe
struct updateCateWithChair: Mappable {
 var idcategory = 0
 var listchair = [chair]()
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idcategory <- map["idcategory"]
        listchair <- map["listchair"]
    }
    
}
