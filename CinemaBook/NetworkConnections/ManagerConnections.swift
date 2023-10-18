//
//  ManagerConnections.swift
//  SEEMT
//
//  Created by macmini_techres_04 on 12/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import Moya
import Alamofire
//import NVActivityIndicatorView

enum ManagerConnections {
    
    case Login(username:String,password:String)
    case config(username:String)
    case Moive(page:Int,limit:Int,status:Int)
    case MovieDetail(idmovie:Int)
    case UpdateAccount(iduser:Int,Fullname:String,Email:String,Phone:String,Birthday:String,avatar:String,Idrole:Int,address:String,gender:Int)
    case getInfoAccount(id:Int)
    case getListVoucher
    case getListTrailler
    case getListCinema
    case getListInterestMovie(dateshow:String,idmovie:Int)
    case getListInterestCinema(dateshow:String,idmovie:Int)
    case getListChair(idroom:Int,Idcinema:Int,idinterest:Int)
    case getListEmployee(iduser:Int,keysearch:String,idcinema:Int)
    case getListRole
    case postCreateNewEmployee(newUser:Users)
    case lockEmployee(id:Int,status:Int)
    case resetPasswordEmployee(id:Int)
    case getInfoUserCinema(iduser:Int)
    case getListRoom(idcinema:Int)
    case getListAutoInterest(roomlist:RoomList,movieList:[MovieList],dayStart:String,dayEnd:String)
     case postListInterest(roomlist:RoomList,movieList:[MovieList],dayStart:String,dayEnd:String)
    case getListInterestsMovie(idcinema:Int,idroom:Int,date:String)
    case getListChairRoom(Idroom:Int)
    case getListCategoryChair(Idroom:Int)
    case postCreateChairInRoom(idcinema:Int,nameroom:String,numberChair:Int,allschair:Int)
    case getListFood(Idcategoryfood:Int)
    case getListFoodCombo
    case createFoodCombo(nametittle:String,discription:String,priceCombo:Int,picture:String,foodCreates: [Food])
    case getListCategoryFood
    case UpdateFoodCombo(idcombo:Int,nametittle:String,discription:String,priceCombo:Int,picture:String,foodCreates: [FoodOfCombo])
    case getInfoInterestMovie(idmovie:Int,idcinema:Int,idroom:Int,idinterest:Int)
    case PostPaymentBill(bill:Bill)
    case getPoint(iduser:Int)
    case postPaymentBillFoodCombo(foodcombobill:PaymentFoodCombo)
    case getListBillinAccount(iduser:Int)
    case getListBillFoodCombo(iduser:Int)
    case getListAllBill(idcinema:Int,status:Int)
    case getListAllBillFoodCombo(idcinema:Int,status:Int)
    case updateSatus(idinterest:Int,status:Int)
}

extension ManagerConnections: TargetType {
    var sampleData: Data {
        return Data()
    }
    

    var baseURL: URL {
        return URL(string: APIEndPoint.Name.GATEWAY_SERVER_URL)!
    }
    var path:String {
        switch self {

        case .Login(let username,let password):
            return  APIEndPoint.Name.urlLogin
        case .config(let username):
            return APIEndPoint.Name.urlConfig
        case .Moive(let page,let limit,let status):
            return APIEndPoint.Name.urlMovie
        case .MovieDetail(let idmovie):
             return APIEndPoint.Name.urlDetail
        case .UpdateAccount(_,_,_,_,_,_,_,_,_):
            return APIEndPoint.Name.urlUpdateAccount
        case .getInfoAccount(let id):
            return APIEndPoint.Name.urlGetInfoAccount
        case .getListVoucher:
            return APIEndPoint.Name.urlGetVoucher
        case .getListTrailler:
            return APIEndPoint.Name.urlGetTrailler
        case .getListCinema:
            return APIEndPoint.Name.urlGetListCinema
        case .getListInterestMovie(let dateshow,let idmovie):
            return APIEndPoint.Name.urlGetInterestMovie
        case .getListInterestCinema(let dateshow,let idmovie):
            return APIEndPoint.Name.urlGetListCinemaofInterest
        case .getListChair(let idroom,let Idcinema,let idinterest):
            return APIEndPoint.Name.urlGetListChair
        case .getListEmployee(let iduser,let keysearch,let idcinema):
            return APIEndPoint.Name.urlGetListEmployee
        case .getListRole:
            return APIEndPoint.Name.urlGetListRole
        case .postCreateNewEmployee(_):
            return APIEndPoint.Name.urlCreateNewEmployee
        case .lockEmployee(let id ,let status):
            return APIEndPoint.Name.urlLockemployee
        case .resetPasswordEmployee(let id):
            return APIEndPoint.Name.urlResetPassword
        case .getInfoUserCinema(let iduser):
            return APIEndPoint.Name.urlGetInfoUserCinema
        case .getListRoom(let idcinema):
              return APIEndPoint.Name.urlGetListRoom
        case .getListAutoInterest(_,_,_,_):
            return APIEndPoint.Name.urlPostAutoInterest
        case .getListInterestsMovie(let idcinema,let idroom,let date):
            return APIEndPoint.Name.urlGetListInterestMovieAuto
        case .postListInterest(_,_,_,_):
            return APIEndPoint.Name.urlInsterestArray
        case .getListChairRoom(let Idroom):
            return APIEndPoint.Name.urlGetListChairRoom
        case .getListCategoryChair(let idroom):
            return APIEndPoint.Name.urlGetListCategoryChair
        case .postCreateChairInRoom(let idcinema,let nameroom,let  numberChair,let allschair ):
            return APIEndPoint.Name.urlCreatChairRoom
        case .getListFood(let Idcategoryfood):
            return APIEndPoint.Name.urlGetListFood
        case .getListFoodCombo:
            return APIEndPoint.Name.urlGetListFooCombo
        case .createFoodCombo(_,_,_,_,_):
            return APIEndPoint.Name.urlCreateFoodCombo
        case .getListCategoryFood:
            return APIEndPoint.Name.urlGetListCategoryFood
        case .UpdateFoodCombo(_,_,_,_,_,_):
            return APIEndPoint.Name.urlUpdateinfofoodCombo
        case .getInfoInterestMovie(let idmovie,let idcinema,let idroom, let idinterest):
            return APIEndPoint.Name.urlGetInfoInterestMovie
        case .PostPaymentBill(_):
            return APIEndPoint.Name.urlPostPayMentBill
        case .getPoint(let iduser):
            return APIEndPoint.Name.urlGetPointInAccount
        case .postPaymentBillFoodCombo(_):
            return APIEndPoint.Name.urlPostPaymentFoodComboStore
        case .getListBillinAccount(let duser):
            return APIEndPoint.Name.urlGetListBillAccount
        case .getListBillFoodCombo(let iduser):
            return APIEndPoint.Name.urlGetListInfoBillFoodCombo
        case .getListAllBill(let idcinema,let status):
            return APIEndPoint.Name.urlGetListBillAll
        case .getListAllBillFoodCombo(let idcinema, let status):
            return APIEndPoint.Name.urlGetListBillAllFoodCombo
        case .updateSatus(let idinterest,let status):
            return APIEndPoint.Name.urlUpdateSatusInterest
        }
    
    }
    var method: Moya.Method {
        switch self {
        case .Login(_,_):
            return .get
        case .config(_):
            return .get
        case .Moive(_,_,_):
            return .get
        case .MovieDetail(_):
            return .get
        case .UpdateAccount(_,_,_,_,_,_,_,_,_):
            return .post
        case .getInfoAccount(_):
            return .get
        case .getListVoucher:
            return .get
        case .getListTrailler:
            return .get
        case .getListCinema:
            return .get
        case .getListInterestMovie(_,_):
            return .get
        case .getListInterestCinema(_,_):
            return .get
        case .getListChair(_,_,_):
            return .get
        case .getListEmployee(_,_,_):
            return .get
        case .getListRole:
            return .get
        case .postCreateNewEmployee(_):
            return .post
        case .lockEmployee(_,_):
            return .get
        case .resetPasswordEmployee(_):
            return .get
        case .getInfoUserCinema(_):
            return .get
        case .getListRoom(_):
            return .get
        case .getListAutoInterest(_,_,_,_):
            return .post
        case .getListInterestsMovie(_,_,_):
            return .get
        case .postListInterest(_,_,_,_):
            return .post
        case .getListRoom(_):
            return .get
        case .getListChairRoom(_):
            return .get
        case .getListCategoryChair(_):
            return .get
        case .postCreateChairInRoom(_,_,_,_):
            return .post
        case .getListFood(_):
            return .get
        case .getListFoodCombo:
            return .get
        case .createFoodCombo(_,_,_,_,_):
            return .post
        case .getListCategoryFood:
            return .get
        case .UpdateFoodCombo(_,_,_,_,_,_):
            return .post
        case .getInfoInterestMovie(_,_,_,_):
            return .get
        case .PostPaymentBill(_):
            return .post
        case .getPoint(_):
            return .get
        case .postPaymentBillFoodCombo(_):
            return .post
        case .getListBillinAccount(_):
            return .get
        case .getListBillFoodCombo(_):
            return .get
        case .getListAllBill(_,_):
            return .get
        case .getListAllBillFoodCombo(_,_):
            return .get
        case .updateSatus(_,_):
            return .post
        }

        
    }
    
    func headerJava(ProjectId:Int = Constans.PROJECT_IDS.PROJECT_ID_SEEMT, Method:Int = Constans.METHOD_TYPE.GET) -> [String:String] {
        if ManageCacheObject.isLogin() {
            return ["token":  ManageCacheObject.getConfig().api_key ?? "", "ProjectId":String(format: "%d", ProjectId), "Method":String(format: "%d", Method)]
        }else {
            if ManageCacheObject.getConfig().api_key != nil {
                return ["token": String(format: ManageCacheObject.getConfig().api_key ?? ""),
                        "ProjectId":String(format: "%d", ProjectId),
                        "Method":String(format: "%d", Method)]
            }else {
                 return ["ProjectId":String(format: "%d", ProjectId), "Method":String(format: "%d", Method)]
            }
         
        }
        
       
      
    }
 
    
    
    
    var headers: [String : String]?
    {
        switch self {
        case .Login(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .config(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .Moive(_,_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .MovieDetail(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .UpdateAccount(_,_,_,_,_,_,_,_,_):
                return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getInfoAccount(_):
              return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListVoucher:
                return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListTrailler:
              return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListCinema:
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListInterestMovie(_,_):
                return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListInterestCinema(_,_):
                return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListChair(_,_,_):
                return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListEmployee(_,_,_):
                       return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListRole:
             return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
            case .postCreateNewEmployee(_):
                 return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .lockEmployee(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .resetPasswordEmployee(_):
                return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getInfoUserCinema(_):
                     return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListRoom(_):
             return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListAutoInterest(_,_,_,_):
             return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getListInterestsMovie(_,_,_):
             return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .postListInterest(_,_,_,_):
             return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getListChairRoom(_):
               return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListCategoryChair(_):
              return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .postCreateChairInRoom(_,_,_,_):
             return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getListFood(_):
              return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListFoodCombo:
              return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .createFoodCombo(_,_,_,_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getListCategoryFood:
                return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .UpdateFoodCombo(_,_,_,_,_,_):
              return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getInfoInterestMovie(_,_,_,_):
             return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .PostPaymentBill(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getPoint(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .postPaymentBillFoodCombo(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getListBillinAccount(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListBillFoodCombo(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListAllBill(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListAllBillFoodCombo(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .updateSatus(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        }
   
    }
    var parameters: [String: Any]? {
        switch self {
        case .Login(let username,let password):
            return ["username":username,
                    "password":password
            ]
        case .config(let username):
            return ["username":username]
        case .Moive(let page, let limit, let status):
            return ["offset_value":page,
                    "page_size":limit,
                    "status": status
            ]
        case .MovieDetail(let idmovie):
            return ["Idmovie":idmovie]
        case .UpdateAccount(let iduser,let Fullname,let Email,let Phone, let Birthday,let avatar,let Idrole,let address, let gender):
            return [
              "Idusers": iduser,
              "Fullname": Fullname,
              "Email": Email,
              "Phone": Phone,
              "Birthday": Birthday,
              "avatar": avatar,
              "gender":gender,
              "address":address,
              "Idrole": Idrole
            ]
            case .getInfoAccount(let id):
                   return [
                      "id":id
                   ]
        case .getListVoucher:
            return [:]
        case .getListTrailler:
            return [:]
        case .getListCinema:
            return [:]
        case .getListInterestMovie(let dateshow,let idmovie):
            return ["date" : dateshow,
                    "Idmovie" : idmovie]
        case .getListInterestCinema(let dateshow,let idmovie):
        return ["date" : dateshow,
                "Idmovie" : idmovie]
        case .getListChair(let idroom,let Idcinema,let idinterest):
            return ["Idroom":idroom,
                "idcinema":Idcinema,
                "idinterest":idinterest
            ]
        case .getListEmployee(let iduser,let keysearch,let idcinema):
            return ["iduser":iduser,
            "keysearch":keysearch,
            "idcinema":idcinema
            ]
        case .getListRole:
           return [:]
        case .postCreateNewEmployee(let newUser):
            return [
                "fullname": newUser.fullname,
                "email": newUser.email,
                "phone": newUser.phone,
                "birthday": newUser.birthday,
                "avatar": newUser.avatar,
                "gender": newUser.gender,
                "idrole": newUser.idrole,
                "idcinema": newUser.idcinema,
                "statuss": newUser.statuss,
                "address": newUser.address
            ]
        case .lockEmployee(let id,let  status):
           return ["idemployee":id,
             "statuss":status
            ]
        case .resetPasswordEmployee(let id):
            return ["idemployee":id]
        case .getInfoUserCinema(let iduser):
            return ["iduser":iduser]
        case .getListRoom(let idcinema):
            return ["idCinema":idcinema]
        case .getListAutoInterest(let roomlist,let  movieList,let dayStart,let dayEnd):
            return [
                "dayStart": dayStart,
              "dayEnd": dayEnd,
              "movieList": movieList.toJSON(),
              "roomList": roomlist.toJSON()
            ]
        case .getListInterestsMovie(let idcinema,let idroom,let date):
            return [
                "idcinema":idcinema,
                "idroom":idroom,
                "date": date
            ]
            case .postListInterest(let roomlist,let  movieList,let dayStart,let dayEnd):
            return [
            "dayStart": dayStart,
            "dayEnd": dayEnd,
            "movieList": movieList.toJSON(),
            "roomList": roomlist.toJSON()
            ]
        case .getListChairRoom(let Idroom):
            return ["Idroom":Idroom]
        case .getListCategoryChair(let Idroom):
            return ["Idroom":Idroom]
        case .postCreateChairInRoom(let idcinema,let nameroom, let numberChair,let allschair):
            return [
                "idcinema":idcinema,
                "nameroom":nameroom,
                "numberChair":numberChair,
                "allschair":allschair
            ]
        case .getListFood(let Idcategoryfood):
            return ["Idcategoryfood":Idcategoryfood]
        case .getListFoodCombo:
            return [:]
        case .createFoodCombo(let nametittle,let discription, let priceCombo,let picture,let foodCreates):
            return [
                "nametittle":nametittle,
                "discription":discription,
                "priceCombo":priceCombo,
                "picture":picture,
                "foodCreates":foodCreates.toJSON()
            ]
        case .getListCategoryFood:
            return [:]
        case .UpdateFoodCombo(let idcombo,let nametittle,let discription, let priceCombo,let picture,let foodCreates):
        return [
            "idcombo":idcombo,
            "nametittle":nametittle,
            "discription":discription,
            "priceCombo":priceCombo,
            "picture":picture,
            "foodCreates":foodCreates.toJSON()
        ]
        case .getInfoInterestMovie(let idmovie,let idcinema,let idroom ,let idinterest):
            return [
                "idmoive":idmovie,
                "idcinema":idcinema,
                "idroom":idroom,
                "idinterest": idinterest
            ]
        case .PostPaymentBill(let bill):
            return [
                "idaccount": bill.iduser,
                "idbill": bill.idbill,
                "idmovie": bill.idmovie,
                "idvoucher": bill.idvoucher,
                "iduser": bill.iduser,
                "idinterest": bill.idinterest,
                "idcinema": bill.idcinema,
                "quantityticket": bill.quantityticket,
                "vat": bill.vat,
                "totalamount": bill.totalamount,
                "note": bill.note,
                "statusbill": bill.statusbill,
                "ticket": bill.tickets.toJSON(),
                "combobill": bill.combobills.toJSON()
            ]
        case .getPoint(let iduser):
            return [
                "iduser": iduser
            ]
        case .postPaymentBillFoodCombo(let foodcombobill):
            return [
                "id": 0,
                "idFoodcombo": foodcombobill.idFoodcombo,
                "idFoodlistcombo": 0,
                "numbers": foodcombobill.numbers,
                "total_price": foodcombobill.total_price,
                "iduser": foodcombobill.iduser,
                "idcinemas": foodcombobill.idcinemas,
                "foodComboBills": foodcombobill.foodComboBills.toJSON()
              
            ]
        case .getListBillinAccount(let iduser):
            return [
                "iduser": iduser
            ]
        case .getListBillFoodCombo(let iduser):
            return ["iduser":iduser]
        case .getListAllBill(let idcinema,let status):
            return [
                "idcinema":idcinema,
                "status": status
            ]
        case .getListAllBillFoodCombo(let idcinema, let status):
            return [
                "idcinema": idcinema,
                "status": status
            ]
        case .updateSatus(let idinterest,let status):
            return [
                "idinterest": idinterest,
                "status": status
            ]
        }
       
    }
    private func encoding(_ httpMethod: HTTPMethod) ->
        ParameterEncoding{
        var encoding: ParameterEncoding = JSONEncoding.default
        if httpMethod == .get {
            encoding = URLEncoding.default
        }
        return encoding
    }
    var task: Task {
        switch self {

        case .Login(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .config(_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .Moive(_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .MovieDetail(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .UpdateAccount(_,_,_,_,_,_,_,_,_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getInfoAccount(_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListVoucher:
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListTrailler:
              return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListCinema:
                return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListInterestMovie(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListInterestCinema(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListChair(_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListEmployee(_,_,_):
        return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListRole:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postCreateNewEmployee(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .lockEmployee(_,_):
               return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .resetPasswordEmployee(_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getInfoUserCinema(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListRoom(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListAutoInterest(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListInterestsMovie(_,_,_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postListInterest(_,_,_,_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListChairRoom(_):
              return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListCategoryChair(_):
                    return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postCreateChairInRoom(_,_,_,_):
               return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListFood(_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListFoodCombo:
               return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .createFoodCombo(_,_,_,_,_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListCategoryFood:
               return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .UpdateFoodCombo(_,_,_,_,_,_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getInfoInterestMovie(_,_,_,_):
              return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .PostPaymentBill(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getPoint(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postPaymentBillFoodCombo(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListBillinAccount(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListBillFoodCombo(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListAllBill(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListAllBillFoodCombo(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .updateSatus(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        }
    }

}
//let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .requestBody)
//let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
//let networkLogger = NetworkLoggerPlugin(verbose: true)
// Define the closure to handle logging output
//let loggerClosure: (String, String, Any...) -> Void = { logLevel, message, _ in
//    print("\(logLevel): \(message)")
//}


// Define the closure to format the request data
let requestDataFormatter: (Data) -> String = { data in
    if let stringData = String(data: data, encoding: .utf8) {
        return stringData
    } else {
        return "Unable to parse request data"
    }
}

// Define the closure to format the response data
let responseDataFormatter: (Data) -> Data = { data in
    // You can implement custom logic to modify or format the response data here
    return data
}
let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .requestBody)
let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)










let endpointClosure = {(target: ManagerConnections) -> Endpoint in
    let defaultEndpont = MoyaProvider.defaultEndpointMapping(for: target)
    return defaultEndpont.adding(newHTTPHeaderFields: ["Conten-type":"Application/json"])
}

let appServiceProvider = MoyaProvider<ManagerConnections>(endpointClosure: endpointClosure, plugins: [networkLogger,NetworkActivityPlugin(networkActivityClosure:{
        (activity,target) in
        switch activity
        {
        case .began:
            print("kêt nối mạng thành công")
            DispatchQueue.main.async {
                if let visiableViewCtrl = UIApplication.shared.keyWindow?.rootViewController{
                    JHProgressHUD.sharedHUD.showInView(visiableViewCtrl.view)
                }
            }
        case .ended:
            print("kêt nối mạng that bai")
            DispatchQueue.main.async {
                if let visiableViewCtrl = UIApplication.shared.keyWindow?.rootViewController{
                    JHProgressHUD.sharedHUD.hide()
                }
            }
        }
    })])
