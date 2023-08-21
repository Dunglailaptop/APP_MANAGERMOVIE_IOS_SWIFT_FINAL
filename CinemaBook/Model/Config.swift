//
//  Account.swift
//  SEEMT
//
//  Created by macmini_techres_04 on 12/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import ObjectMapper

struct ConfigModel: Mappable {
    var config: Config?
    var message: String?
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        message <- map["message"]
        config <- map["data"]
        
    }
}


struct Config: Mappable {
    var type:String!
    var version:Int!
    var domain:String!
    var api_key:String!
    var api_domain:String!
    var report_domain:String!
    var report_domain_v2:String!
    var realtime_domain:String!
    var system_server:String!
    var current_domain:String!
    var install_app_url:String!
    var aloline_new_feed_content_url_path:String!
    var is_allow_forgot_password:String!
    var date_time:String!
    var api_chat_tms:String!
    var api_chat_aloline:String!
    var api_upload:String!
    var api_upload_v2:String!
    var api_upload_short:String!
    var api_connection:String!
    var api_log:String!
    var ads_domain:String!
    var chat_domain:String!
    var api_oauth_node:String!
    var api_saler:String!
    var socket_conect_login:String!
    
    init () {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        type <- map["type"]
        version <- map["version"]
        domain <- map["domain"]
        api_key <- map["apiKey"]
        api_domain <- map["api_domain"]
        report_domain <- map["report_domain"]
        report_domain_v2 <- map["report_domain_v2"]
        realtime_domain <- map["realtime_domain"]
        system_server <- map["system_server"]
        current_domain <- map["current_domain"]
        install_app_url <- map["install_app_url"]
        aloline_new_feed_content_url_path <-
            map["aloline_new_feed_content_url_path"]
        is_allow_forgot_password <-
            map["is_allow_forgot_password"]
        date_time <- map["date_time"]
        api_chat_tms <- map["api_chat_tms"]
        api_chat_aloline <- map["api_chat_aloline"]
        api_upload <- map["api_upload"]
        api_upload_v2 <- map["api_upload_v2"]
        api_upload_short <- map["api_upload_short"]
        api_connection <- map["api_connection"]
        api_log <- map["api_log"]
        ads_domain <- map["ads_domain"]
        chat_domain <- map["chat_domain"]
        api_oauth_node <- map["api_oauth_node"]
        api_saler <- map["api_saler"]
        socket_conect_login <- map["socket_conect_login"]
    }
}
