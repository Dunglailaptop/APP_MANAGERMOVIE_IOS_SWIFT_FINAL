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


struct PaymentFoodCombo: Mappable {
        var id = 0
        var idFoodcombo = 0
        var idFoodlistcombo = 0
        var numbers = 0
        var datetimes = ""
        var total_price = 0
        var iduser = 0
        var idcinemas = 0
        var foodComboBills = [FoodComboList]()
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         id <- map["id"]
         idFoodcombo <- map["idFoodcombo"]
         idFoodlistcombo <- map["idFoodlistcombo"]
         numbers <- map["numbers"]
         datetimes <- map["datetimes"]
         total_price <- map["total_price"]
         foodComboBills <- map["foodComboBills"]
        iduser <- map["iduser"]
        idcinemas <- map["idcinemas"]
    }
}
struct PaymentInfoBillFoodCombo: Mappable {
    var id = 0
        var total_prices = 0
        var quantity = 0
        var time = ""
        var status = 0
        var listfoodcombo = [FoodCombo]()
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        total_prices <- map["total_prices"]
        quantity <- map["quantity"]
        time <- map["time"]
        listfoodcombo <- map["listfoodcombo"]
        id <- map["id"]
        status <- map["status"]
    }
}


struct FoodComboList: Mappable {
    var id = 0
    var idfoodcombo = 0
    var idfoodcombobill = 0

    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        idfoodcombo <- map["idfoodcombo"]
        idfoodcombobill <- map["idfoodcombobill"]
    }
}
struct BillInfoAccount: Mappable {
    var idbill = 0
        var totalamount = 0
        var datebill =  ""
        var quantityticket = 0
        var statusbill = 0
        var namemovie = ""
        var poster = ""
        var starttime = ""
        var endtime = ""
        var numberchair = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idbill <- map["idbill"]
         totalamount <- map["totalamount"]
         datebill <- map["datebill"]
         quantityticket <- map["quantityticket"]
         statusbill <- map["statusbill"]
         namemovie <- map["namemovie"]
         poster <- map["poster"]
         starttime <- map["starttime"]
         endtime <- map["endtime"]
         numberchair <- map["numberchair"]
    }
}
