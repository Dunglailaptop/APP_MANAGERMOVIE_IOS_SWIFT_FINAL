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
    var like = 0 // like video
    var heart = 0 // tha tym
    var commentscount = 0
    var statuslike = 0
    var statusheart = 0
    var messagevideos = [Comments]()
  
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
          messagevideos <- map["messagevideos"]
         like <- map["like"]
         heart <- map["heart"]
         statuslike <- map["statuslike"]
         statusheart <- map["statusheart"]
         commentscount <- map["commentscount"]
    }
   
}
struct Comments: Mappable {
    
        var image = ""
        var nameuser = "phamkhanhhuy"
        var message = "ok good"
//        var like = 0
//        var heart = 0
    
    init(){
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         image <- map["image"]
         nameuser <- map["nameuser"]
         message <- map["message"]
//         like <- map["like"]
//         heart <- map["heart"]
        
    }
}
//create message
struct likeandheart: Mappable {
    var idliekandcomment = 0
     var likes = 0
     var comments = 0
     var idvideo = 0
     var Idusers = 0
     var numberlike = 0
    var numberheart = 0
    init(){}
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        idliekandcomment <- map["idliekandcomment"]
        likes <- map["likes"]
        comments <- map["comments"]
        idvideo <- map["idvideo"]
        Idusers <- map["Idusers"]
        numberlike <- map["numberlike"]
        numberheart <- map["numberheart"]
    }
}
struct MessageComments: Mappable {
   var idcomment = 0
    var iduser = ManageCacheObject.getCurrentUserInfo().idusers
    var idvideo = 0
      var message = ""
      var heart = 0
      var likes = 0
    
    init() {}
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
         idcomment <- map["idcomment"]
          iduser <- map["iduser"]
          idvideo <- map["idvideo"]
            message <- map["message"]
            heart <- map["heart"]
            likes <- map["likes"]
    }
}
