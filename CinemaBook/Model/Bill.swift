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
        var idvoucher = 0
       var listfood = [listfoodaddbill]()
    var dateget = ""
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
        idvoucher <- map["idvoucher"]
        listfood <- map["listfood"]
        dateget <- map["dateget"]
    }
}
struct PaymentInfoBillFoodCombo: Mappable {
    var id = 0
        var total_prices = 0
        var quantity = 0
        var time = ""
        var status = 0
        var namecinema = ""
        var price = 0
        var percent = 0
        var namevoucher = ""
        var poster = ""
        var listfoodcombo = [FoodCombo]()
        var listfood = [listfoodaddbill]()
    var dateget = ""
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
        listfood <- map["listfood"]
        namecinema <- map["namecinema"]
         price  <- map["price"]
         percent <- map["percent"]
         namevoucher <- map["namevoucher"]
         poster <- map["poster"]
        dateget <- map["dateget"]
    }
}


struct FoodComboList: Mappable {
    var id = 0
    var idfoodcombo = 0
    var idfoodcombobill = 0
    var numberbuyincombo = 0
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        idfoodcombo <- map["idfoodcombo"]
        idfoodcombobill <- map["idfoodcombobill"]
        numberbuyincombo <- map["numberbuyincombo"]
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
    
    init() {
        
    }
    
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
struct detailBill: Mappable {
        var idbill = 0
        var dateBill = ""
        var namemovie = ""
        var timeall = 0
        var starttime = ""
        var endTime = ""
        var showMovie = ""
        var nameroom = ""
        var idroom = 0
        var status = 0
        var detailTickets = [DetailTicket]()
        var detailFoodcombos = [DetailFoodComboBill]()
var total_price = 0
var quantityticket = 0
        var namevoucher = ""
        var poster = ""
        var price = 0
        var percent = 0
    
    init() {}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idbill <- map["idbill"]
         dateBill <- map["dateBill"]
         namemovie <- map["namemovie"]
         timeall <- map["timeall"]
         starttime <- map["starttime"]
         endTime <- map["endTime"]
         showMovie <- map["showMovie"]
         nameroom <- map["nameroom"]
         idroom <- map["idroom"]
         status <- map["status"]
         detailTickets <- map["detailTickets"]
         detailFoodcombos <- map["detailFoodcombos"]
         total_price <- map["total_price"]
         quantityticket  <- map["quantityticket"]
         namevoucher <- map["namevoucher"]
         poster  <- map["poster"]
         price  <- map["price"]
         percent  <- map["percent"]
    }
}
struct DetailTicket: Mappable {
    var idbill = 0
    var idchair = 0
    var namechair = ""
    var price = 0
    init(){}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         idbill <- map["idbill"]
         idchair <- map["idchair"]
         namechair <- map["namechair"]
         price <- map["price"]
    }
}
struct DetailFoodComboBill: Mappable {
    var idfoodcombo = 0
    var namefoodcombo = ""
    var totalprice = 0
    var image = ""
    
    init() {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         idfoodcombo <- map["idfoodcombo"]
         namefoodcombo <- map["namefoodcombo"]
         totalprice <- map["totalprice"]
         image <- map["image"]
    }
}
struct PaymentVNpay: Mappable {
    var idorder = 0
            var amount = 0
            var urlpayment = ""
    
    init(){}
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        idorder <- map["idorder"]
        amount <- map["amount"]
        urlpayment <- map["urlpayment"]
    }
}
struct IdbillPaymentVNPAYRequest: Mappable {
    var idpaymentvnpay = 0
    var vnp_Amount = ""
    var vnp_BankCode = ""
    var vnp_BackTranNo = ""
     var vnp_CardType = ""
    var vnp_OrderInfo = ""
    var vnp_PayDate =  ""
    var vnp_ResponseCode = ""
    var vnp_TmnCode = ""
    var vnp_TransactionNo = ""
    var vnp_TransactionSatus = ""
    var vnp_TxnRef = ""
    var vnp_SecureHash = ""
    var idbills = 0
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        idpaymentvnpay <- map["idpaymentvnpay"]
        vnp_Amount <- map["idpaymentvnpay"]
        vnp_BankCode <- map["vnp_BankCode"]
        vnp_BackTranNo <- map["vnp_BackTranNo"]
        vnp_CardType <- map["vnp_CardType"]
        vnp_OrderInfo <- map["vnp_OrderInfo"]
        vnp_PayDate <- map["vnp_PayDate"]
        vnp_ResponseCode <- map["vnp_ResponseCode"]
        vnp_TmnCode <- map["vnp_TmnCode"]
        vnp_TransactionNo <- map["vnp_TransactionNo"]
        vnp_TransactionSatus <- map["vnp_TransactionSatus"]
        vnp_TxnRef <- map["vnp_TxnRef"]
        vnp_SecureHash <- map["vnp_SecureHash"]
        idbills <- map["idbills"]
    }
}

//bill info room
struct billinfowithroom: Mappable {
        var idbill = 0
        var totalamount = 0
        var chairess = [chair]()
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         idbill <- map["idbill"]
         totalamount <- map["totalamount"]
         chairess  <- map["chairess"]
    }
}
struct listfoodaddbill: Mappable {
        var idfood = 0
        var numberfood = 0
         var namefood = ""
        var picture = ""
       var idcombo = 0
    init(){}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idfood <- map["idfood"]
        numberfood <- map["numberfood"]
        namefood <- map["namefood"]
        picture <- map["picture"]
        idcombo <- map["idcombo"]
    }
    
   
}
