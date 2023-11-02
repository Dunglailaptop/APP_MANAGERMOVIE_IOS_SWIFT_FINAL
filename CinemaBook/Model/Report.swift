//
//  Report.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 30/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift
import RxRelay
import ObjectMapper

struct ReportTotalAll: Mappable {
            var totalbill = 0
            var totalbillwait = 0
            var totalfoodwithbill = 0
            var totalfood = 0
            var totalfoodwait = 0
    var reportTicketnews = [ReportTicket]()
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         totalbill <- map["totalbill"]
         totalbillwait <- map["totalbillwait"]
         totalfoodwithbill <- map["totalfoodwithbill"]
         totalfood <- map["totalfood"]
         totalfoodwait <- map["totalfoodwait"]
        reportTicketnews <- map["reportTicketnews"]
    }
}

struct ReportTicket: Mappable {
            var datebill =  ""
            var total = 0
            var priceCombo = 0
            var totalpricefoodcomboorder = 0
            var report_type = 0
            var totalwait = 0
            var totalpricefoodcomboorderwait = 0
    init() {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         datebill <- map["datebill"]
         total <- map["total"]
         priceCombo <- map["priceCombo"]
         totalpricefoodcomboorder <- map["totalpricefoodcomboorder"]
         totalwait <- map["totalwait"]
         totalpricefoodcomboorderwait <- map["totalpricefoodcomboorderwait"]
    }
}
struct ReportMovie: Mappable {
            var totals = 0
            var idmovie = 0
            var poster = ""
            var datebill = ""
            var stt = 0
    var namemovie = ""
    init() {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         totals <- map["totals"]
         idmovie <- map["idmovie"]
         poster <- map["poster"]
         datebill <- map["datebill"]
        stt <- map["stt"]
        namemovie <- map["namemovie"]
    }
    
}
struct ReportFood: Mappable {
            var idfood = 0
            var idcombo = 0
            var image = ""
            var stt = 0
            var namefood = ""
            var totals = 0
            var datetimes = ""
    
    init() {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idfood <- map["idfood"]
         idcombo <- map["idcombo"]
         image <- map["image"]
         stt <- map["stt"]
         namefood <- map["namefood"]
         totals <- map["totals"]

         datetimes  <- map["datetimes"]
    }
}
