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
        static let urlLockemployee = "/Employee/Lockemployee"
        static let urlResetPassword = "/Employee/resetpasswordemployee"
        static let urlGetInfoUserCinema = "/Cinema/getInfoUserCinema"
        static let urlGetListRoom = "/Room/getlistRoom"
        static let urlPostAutoInterest = "/AutointerestMovie/AutoGetListInterest"
        static let urlGetListInterestMovieAuto = "/AutointerestMovie/getListInterest"
        static let urlInsterestArray = "AutointerestMovie/InsertIntoAutoInterest"
        static let urlGetListChairRoom = "Chair/getlistchairRoom"
        static let urlGetListCategoryChair = "CategoryChair/getlistCategoryChairByRoom"
        static let urlCreatChairRoom = "Chair/CreateChairInRoom"
        static let urlGetListFood = "/FoodCombo/getListFood"
        static let urlGetListFooCombo = "/FoodCombo/getListComboFood"
        static let urlCreateFoodCombo = "/FoodCombo/AddFoodComboFood"
        static let urlGetListCategoryFood = "/FoodCombo/getListCategoryFood"
        static let urlUpdateinfofoodCombo = "/FoodCombo/UpdateInfoCombofood"
        static let urlGetInfoInterestMovie = "/AutointerestMovie/getInfoInterestMovie"
        static let urlPostPayMentBill = "/Bill/PaymentBill"
        static let urlGetPointInAccount = "/Account/getInfoPointAccount"
        static let urlPostPaymentFoodComboStore = "/Bill/postPaymentFoodComboBill"
        static let urlGetListBillAccount = "/Bill/getListBillinAccount"
        static let urlGetListInfoBillFoodCombo = "/Bill/getListBillFoodinAccount"
        static let urlGetListBillAll = "/Bill/getListAllBillTicket"
        static let urlGetListBillAllFoodCombo = "/Bill/getListAllBillFoodCombo"
        static let urlUpdateSatusInterest = "/AutointerestMovie/UpdateStatusInterest"
        static let urlupdateInterestMovie = "/AutointerestMovie/UpdateInterestMovie"
        static let urlgetListMovieWithResetTime = "/Movie/GetListMovieWithTimeReset"
        static let urlgetListCategoryMovie = "/CategoryMovie/getlistcategoryMovie"
        static let urlgetListNation = "CategoryMovie/getlistcategoryNation"
        static let urlCreateMovieNew = "/Movie/CreateMovieNew"
    }
    
}
