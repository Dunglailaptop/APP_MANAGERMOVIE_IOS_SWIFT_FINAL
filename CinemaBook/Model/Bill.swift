//
//  Bill.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 06/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper

struct Bill: Mappable{
     
        var idbill = 0
        var idmovie = 0
        var idvoucher = 0
        var  iduser = 0
        var   idinterest = 0
        var  idcinema = 0
        var quantityticket = 0
        var vat = 0
        var totalamount = 0
        var datebill = ""
        var note = ""
        var statusbill = 0
    var tickets = [ticket]()
    var combobills = [FoodCombo]()
    
    init() {
        
    }
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
       
         idbill <- map["idbill"]
         idmovie <- map["idmovie"]
         idvoucher <- map["idvoucher"]
          iduser <- map["iduser"]
           idinterest <- map["idinterest"]
          idcinema <- map["idcinema"]
         quantityticket <- map["quantityticket"]
         vat <- map["vat"]
         totalamount <- map["totalamount"]
         datebill <- map["datebill"]
         note <- map["note"]
         statusbill <- map["statusbill"]
        tickets <- map["ticket"]
        combobills <- map["combobill"]
    }
}
struct ticket: Mappable {
            var idticket = 0
            var idchair = 0
            var idinterest = 0
            var pricechair = 0
            var idbill = 0
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         idticket <- map["idticket"]
        idchair <- map["idchair"]
         idinterest <- map["idinterest"]
         pricechair  <- map["pricechair"]
         idbill  <- map["idbill"]
    }
    
}
struct combobill: Mappable {
            var idBillfoodCombo = 0
            var idcombo = 0
            var idbill = 0
    init() {
        
    }
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idBillfoodCombo <- map["idBillfoodCombo"]
        idcombo <- map["idcombo"]
        idbill <- map["idbill"]
    }
}
