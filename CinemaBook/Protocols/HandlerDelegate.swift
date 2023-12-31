//
//  HandlerDelegate.swift
//  myapp
//
//  Created by macmini_techres_04 on 22/06/2023.
//

import Foundation


protocol ChooseCityDelegate {
    func callbackchoosecity(city: String)
}

protocol  LogoutConfirm {
    func callbackAccessConfirm()
}

protocol DialogAccessEmployee {
    func callbackDialogAccess(id:Int,status:Int)
}
protocol DialogListPopupInterestMovie {
    func callbackDialogListMovie(Movies:[Movie],date:String,idroom:Int,nameroom:String)
}
protocol  DialogListPopupInterestRoom {
    func callbackDialogListRoom(idroom:Int,date:String)
}
protocol CallBackCallApiLoadListChair {
   func callbackCallapiLoadListchairRoom(Idroom:Int)
}
protocol InputMoneyDelegatePriceList {
    func callbackInputPriceList()
}
protocol InputMoneyDelegate {
    func callBackInputMoney(amount:Int, position:Int)
}
protocol InputQuantityDelegate {
    func callbackInputQuantity(number:Float, position:Int)
}

protocol DialogNotPayment {
    func callBackDialogNotPayment()
}
protocol DialogPayment {
    func callbackPayment()
}

protocol DialogUpdateSatusInterest
{
    func callbackUpdatesatusInterest(idinterest:Int,status:Int)
}
protocol CaculatorInputQuantityDelegate {
    func callbackCaculatorInputQuantity(number:Float, position:Int)
}
protocol DialogchooseInterestMovies {
    func callbackUpdateInterestMovies(idinterest:Int,idmovie:Int)
}
protocol DialogChooseCategoryMovie {
    func callbackChooseCategoryMovie(Idcategory: Int)
}

protocol DialogCreateCategoryChair {
    func callbackcreateCategoryChair(categorychairinfo: CategoryChair,type:String)
}
protocol DialogCreateRoomInfo {
    func callbackCreateRoominfo()
}
protocol DialogUpdateListCategoryChair {
    func callbackUpdatelistcategorychair()
}
protocol CalculatorMoneyDelegate {
    func callBackCalculatorMoney(amount:Int, position:Int)
}
protocol callbackurl {
    func callbackurlvideo(url:String)
}
//protocol CallBackValueChooseDateinStore {
//    func callbackCinemaValue(idcinema:idcinema)
//}
