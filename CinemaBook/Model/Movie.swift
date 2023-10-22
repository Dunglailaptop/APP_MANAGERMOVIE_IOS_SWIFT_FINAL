


import UIKit
import ObjectMapper

struct  Movie: Mappable {
  var movieID = 0
var namemovie =  ""
var author = ""
var yearbirthday = ""
var timeall = 0
var describes = ""
var poster = ""
var statusshow = 0
var videofile = ""
var ischeck = 0
var dayStart = "2023-09-19T16:02:37.650Z"
var dayEnd = "2023-09-19T16:02:37.650Z"
var isSelected = DEACTIVE
var idvideo = 0
var idcategory = 0
var idnation = 0
var namecategorymovie = ""
var namenation = ""
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
    movieID <- map["movieID"]
    namemovie <- map["namemovie"]
    author <- map["author"]
    yearbirthday <- map["yearbirthday"]
    timeall <- map["timeall"]
    describes <- map["describes"]
    poster <- map["poster"]
        statusshow <- map["statusshow"]
        videofile <- map["videofile"]
        idcategory <- map["idcategory"]
        idnation <- map["idnation"]
        namecategorymovie <- map["namecategorymovie"]
        namenation <- map["namenation"]
    }
}
