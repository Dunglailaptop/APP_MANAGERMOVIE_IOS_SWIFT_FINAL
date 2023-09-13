//
//  Struct.swift
//  SEEMT
//
//  Created by macmini_techres_04 on 12/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation

public struct APIEndPoint {
    static let endUrlPoint = Environment.develop.rawValue
    static let version = "v2"
    static let version_v1 = "v1"
    static let versions = "v3"
    
    enum Environment:String {
        
        case develop = "http://localhost:5062"
      
        
    }
    
    struct Name {
     static let GATEWAY_SERVER_URL = endUrlPoint
        static let urlConfig = "/Config/Config"
        static let urlLogin = "/Account/Logins"
        static let urlMovie = "/Movie/ListMovie"
        static let urlDetail = "/Movie/DetailMovie"
        static let urlUpdateAccount = "/Account/UpdateAccount"
        static let urlGetInfoAccount = "/Account/getInfoAccount"
        static let urlGetVoucher = "/voucher/getlistvoucher"
        static let urlGetTrailler = "/videoUser/getlistvideoTrailler"
        static let urlGetListCinema = "/Cinema/getListCinema"
        static let urlGetInterestMovie = "/interestMovie/getListInterestCinema"
        static let urlGetListCinemaofInterest = "/interestMovie/getlistcinema"
        static let urlGetListChair = "/Chair/getlistchair"
        static let urlGetListEmployee = "/Employee/getlistemployee"
        static let urlGetListRole = "/Account/getrole"
        static let urlCreateNewEmployee = "/Employee/Createnewemployee"
    }
    
}
