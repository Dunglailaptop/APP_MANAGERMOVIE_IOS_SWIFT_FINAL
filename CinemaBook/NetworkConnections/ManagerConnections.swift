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
    case Moive(page:Int,limit:Int,status:Int,Idcategory:Int,dateFrom:String,dateTo:String)
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
    case getListAutoInterest(roomlist:RoomList,movieList:[MovieList],dayStart:String,dayEnd:String,breakTime:Int)
    case postListInterest(roomlist:RoomList,movieList:[MovieList],dayStart:String,dayEnd:String,resetTime:Int)
    case getListInterestsMovie(idcinema:Int,idroom:Int,date:String)
    case getListChairRoom(Idroom:Int)
    case getListCategoryChair
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
    case getListBillinAccount(iduser:Int,status:Int)
    case getListBillFoodCombo(iduser:Int,statusfoodbill:Int)
    case getListAllBill(idcinema:Int,status:Int,datefrom:String,dateto:String)
    case getListAllBillFoodCombo(idcinema:Int,status:Int,datefrom:String,dateto:String)
    case updateSatus(idinterest:Int,status:Int)
    case updateInterestMovie(idinterest:Int,idmovie:Int)
    case getListMovieWithResetTime(breakTime:Int)
    case getListCategoryMovie
    case getListNation
    case CreateMovie(movievalue: Movie,videousers:videouser)
    case UpdateMovie(movievalue: Movie,videousers:videouser)
    case UpdateStatusMovie(idmovie:Int,status:Int)
    case GetListCategoryChairInRoom(idroom:Int)
    case CreateCategoryChair(categoryinfo: CategoryChair)
    case getDetailInfoCategoryChair(idcategory:Int)
    case updateCategoryInChairRoom(listchair: updateCateWithChair)
    case updateInfoCategoryChair(infocategory: CategoryChair)
    case getDetailBillInManager(idbill:Int)
    case createNewVoucher(vouchers: voucher)
    case getDetailVoucher(idvoucher:Int)
    case UpdateDetailVoucher(vouchers: voucher)
    case createFoodNew(food:Food)
    case getDetailfood(idfood:Int)
    case updateinfodetailfood(food:Food)
    case GetReportTicket(report_type:Int)
    case ReportMovie(report_type:Int)
    case reportFood(report_type:Int)
    case reportDetailAll
    case paymentVNPAY(amount:Int,
              idorder:Int)
    case getIdbillPayment(idbill:Int)
    case getOTPInEmail(emails:String)
    case confrimOTP(emails:String,enteredOTP:String,username:String,passwords:String,fullname:String)
    case getListMovieBooking(status:Int)
    case getcheckaccountExistsSigin(username:String)
    case getForgotPassword(username:String)
    case confirmfogotAccount(emails:String,enteredOTP:String,iduser:Int)
    case changepassword(newpassword:String,username:String)
    case saveCacheVNPAY(bill:Bill)
    case getDetailInfoCinema(idcinema:Int)
    case getNoTiFaction(iduser:Int)
    case getUpdateCinemaInfo(datacinema:Cinema)
    //billfood
    case saveCacheBillFood(datapaymentBillfood: PaymentFoodCombo)
    case createLinkVNPAYBILLFOODCOMBO(amount:Int,idorder:Int)
    case chekcBillFood(idbill:Int)
    case getlistinterestwithroom(date:String,idroom:Int)
    case getlistinterestMovieRoom(date:String,idroom:Int)
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
        case .Moive(let page,let limit,let status,let Idcategory,let dateFrom,let dateTo):
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
        case .getListAutoInterest(_,_,_,_,_):
            return APIEndPoint.Name.urlPostAutoInterest
        case .getListInterestsMovie(let idcinema,let idroom,let date):
            return APIEndPoint.Name.urlGetListInterestMovieAuto
        case .postListInterest(_,_,_,_,_):
            return APIEndPoint.Name.urlInsterestArray
        case .getListChairRoom(let Idroom):
            return APIEndPoint.Name.urlGetListChairRoom
        case .getListCategoryChair:
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
        case .getListBillinAccount(let duser,let status):
            return APIEndPoint.Name.urlGetListBillAccount
        case .getListBillFoodCombo(let iduser,let statusfoodbill):
            return APIEndPoint.Name.urlGetListInfoBillFoodCombo
        case .getListAllBill(let idcinema,let status,let datefrom,let dateto):
            return APIEndPoint.Name.urlGetListBillAll
        case .getListAllBillFoodCombo(let idcinema, let status,let datefrom,let dateto):
            return APIEndPoint.Name.urlGetListBillAllFoodCombo
        case .updateSatus(let idinterest,let status):
            return APIEndPoint.Name.urlUpdateSatusInterest
        case .updateInterestMovie(let idinterest,let idmovie):
            return APIEndPoint.Name.urlupdateInterestMovie
        case .getListMovieWithResetTime(let breakTime):
            return APIEndPoint.Name.urlgetListMovieWithResetTime
        case .getListNation:
            return APIEndPoint.Name.urlgetListNation
        case .getListCategoryMovie:
            return APIEndPoint.Name.urlgetListCategoryMovie
        case .CreateMovie(_,_):
            return APIEndPoint.Name.urlCreateMovieNew
        case .UpdateMovie(_,_):
            return APIEndPoint.Name.urlUpdateMovie
        case  .UpdateStatusMovie(_,_):
            return APIEndPoint.Name.urlUpdateStatusMovie
        case .GetListCategoryChairInRoom(let idroom):
            return APIEndPoint.Name.urlGetListCategoryChairinRoom
        case .CreateCategoryChair(_):
            return APIEndPoint.Name.urlPostCreateCategoryChair
        case .getDetailInfoCategoryChair(let idcategory):
            return APIEndPoint.Name.urlGetDetailInfoCategoryChair
        case .updateCategoryInChairRoom(_):
            return APIEndPoint.Name.urlUpdateCategoryInChairRoom
        case .updateInfoCategoryChair(_):
            return APIEndPoint.Name.urlUpdateInfoDetailCategoryChair
        case .getDetailBillInManager(let idbill):
            return APIEndPoint.Name.urlGetDetailBillManager
        case .createNewVoucher(_):
            return APIEndPoint.Name.urlCreateNewVoucher
        case .getDetailVoucher(let idvoucher):
            return APIEndPoint.Name.urlGetDetailInfoVoucher
        case .UpdateDetailVoucher(_):
            return APIEndPoint.Name.urlUpdateInfoVoucher
        case .createFoodNew(_):
            return APIEndPoint.Name.urlcreateNewFood
        case .getDetailfood(let idfood):
            return APIEndPoint.Name.urlGetDetailFood
        case .updateinfodetailfood(_):
            return APIEndPoint.Name.urlUpdateInfoDetailfood
        case .GetReportTicket(let report_type):
            return APIEndPoint.Name.urlReportTicketAll
        case .ReportMovie(let report_type):
            return APIEndPoint.Name.urlReportMovie
        case .reportFood(let report_type):
            return APIEndPoint.Name.urlreportfood
        case .reportDetailAll:
            return APIEndPoint.Name.urlReportDetail
        case .paymentVNPAY(let amount,let idorder):
            return APIEndPoint.Name.urlPaymentVnpay
        case .getIdbillPayment(let idbill):
            return APIEndPoint.Name.urlGetIdbillPaymentVNPay
        case .getOTPInEmail(let emails):
            return APIEndPoint.Name.urlGetOTPInEmail
        case .confrimOTP(let emails,let enteredOTP,_,_,_):
            return APIEndPoint.Name.urlConfrimOTPEMAIL
        case .getListMovieBooking(let status):
            return APIEndPoint.Name.urlGetListBookingMovie
        case .getcheckaccountExistsSigin(let username):
            return APIEndPoint.Name.urlGetchechkaccount
        case .getForgotPassword(let username):
            return APIEndPoint.Name.urlForgotPassword
        case .confirmfogotAccount(let emails,let enteredOTP,let iduser):
            return APIEndPoint.Name.urlConfirmAccountForgotPassword
        case .changepassword(let newpassword,let username):
            return APIEndPoint.Name.urlChangePassword
        case .saveCacheVNPAY(_):
            return APIEndPoint.Name.urlSaveCacheBillVnapy
        case .getDetailInfoCinema(let idcinema):
            return APIEndPoint.Name.urlGetInfoDetialCinema
        case .getNoTiFaction(let iduser):
            return APIEndPoint.Name.urlNotiFaction
        case .getUpdateCinemaInfo(let datacinema):
            return APIEndPoint.Name.urlUpdateInfoDetailcinema
        case .saveCacheBillFood(_):
            return APIEndPoint.Name.urlSaveCacheBillFood
        case .createLinkVNPAYBILLFOODCOMBO(let amount,let idorder):
            return APIEndPoint.Name.urlCreatelinkVnpayBillFood
        case .chekcBillFood(let idbill):
            return APIEndPoint.Name.urlcheckPaymetBillFood
        case .getlistinterestwithroom(let date,let idroom):
            return APIEndPoint.Name.urlgetListInterestWithRoom
        case .getlistinterestMovieRoom(let date,let idroom):
            return APIEndPoint.Name.urlgetinterestlistMovieWithRoom
        }
    
    }
    var method: Moya.Method {
        switch self {
        case .Login(_,_):
            return .get
        case .config(_):
            return .get
        case .Moive(_,_,_,_,_,_):
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
        case .getListAutoInterest(_,_,_,_,_):
            return .post
        case .getListInterestsMovie(_,_,_):
            return .get
        case .postListInterest(_,_,_,_,_):
            return .post
        case .getListRoom(_):
            return .get
        case .getListChairRoom(_):
            return .get
        case .getListCategoryChair:
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
        case .getListBillinAccount(_,_):
            return .get
        case .getListBillFoodCombo(_,_):
            return .get
        case .getListAllBill(_,_,_,_):
            return .get
        case .getListAllBillFoodCombo(_,_,_,_):
            return .get
        case .updateSatus(_,_):
            return .post
        case .updateInterestMovie(_,_):
            return .post
        case .getListMovieWithResetTime(_):
            return .get
        case .getListNation:
            return .get
        case .getListCategoryMovie:
            return .get
        case .CreateMovie(_,_):
            return .post
        case .UpdateMovie(_,_):
            return .post
        case .UpdateStatusMovie(_,_):
            return .post
        case .GetListCategoryChairInRoom(_):
            return .get
        case .CreateCategoryChair(_):
            return .post
        case .getDetailInfoCategoryChair(_):
            return .get
        case .updateCategoryInChairRoom(_):
            return .post
        case .updateInfoCategoryChair(_):
            return .post
        case .getDetailBillInManager(_):
            return .get
        case .createNewVoucher(_):
            return .post
        case .getDetailVoucher(_):
            return .get
        case .UpdateDetailVoucher(_):
            return .post
        case .createFoodNew(_):
            return .post
        case .getDetailfood(_):
            return .get
        case .updateinfodetailfood(_):
            return .post
        case .GetReportTicket(_):
            return .get
        case .ReportMovie(_):
            return .get
        case .reportFood(_):
            return .get
        case .reportDetailAll:
            return .get
        case .paymentVNPAY(_,_):
            return .post
        case .getIdbillPayment(_):
            return .get
        case .getOTPInEmail(_):
            return .get
        case .confrimOTP(_,_,_,_,_):
            return .post
        case .getListMovieBooking(_):
            return .get
        case .getcheckaccountExistsSigin(_):
            return .get
        case .getForgotPassword(_):
            return .get
        case .confirmfogotAccount(_,_,_):
            return .get
        case .changepassword(_,_):
            return .post
        case .saveCacheVNPAY(_):
            return .post
        case .getDetailInfoCinema(_):
            return .get
        case .getNoTiFaction(_):
            return .get
        case .getUpdateCinemaInfo(_):
            return .post
        case .saveCacheBillFood(_):
            return .post
        case .createLinkVNPAYBILLFOODCOMBO(_,_):
            return .post
        case .chekcBillFood(_):
            return .get
        case .getlistinterestwithroom(_,_):
            return .get
        case .getlistinterestMovieRoom(_,_):
            return .get
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
        case .Moive(_,_,_,_,_,_):
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
        case .getListAutoInterest(_,_,_,_,_):
             return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getListInterestsMovie(_,_,_):
             return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .postListInterest(_,_,_,_,_):
             return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getListChairRoom(_):
               return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListCategoryChair:
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
        case .getListBillinAccount(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListBillFoodCombo(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListAllBill(_,_,_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListAllBillFoodCombo(_,_,_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .updateSatus(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .updateInterestMovie(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getListMovieWithResetTime(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListCategoryMovie:
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getListNation:
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .CreateMovie(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .UpdateMovie(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .UpdateStatusMovie(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .GetListCategoryChairInRoom(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .CreateCategoryChair(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getDetailInfoCategoryChair(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .updateCategoryInChairRoom(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .updateInfoCategoryChair(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getDetailBillInManager(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .createNewVoucher(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getDetailVoucher(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .UpdateDetailVoucher(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .createFoodNew(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getDetailfood(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .updateinfodetailfood(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .GetReportTicket(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .ReportMovie(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .reportFood(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .reportDetailAll:
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .paymentVNPAY(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getIdbillPayment(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getOTPInEmail(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .confrimOTP(_,_,_,_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getListMovieBooking(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getcheckaccountExistsSigin(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getForgotPassword(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .confirmfogotAccount(_,_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .changepassword(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .saveCacheVNPAY(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .getDetailInfoCinema(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getNoTiFaction(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getUpdateCinemaInfo(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .saveCacheBillFood(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .createLinkVNPAYBILLFOODCOMBO(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.POST)
        case .chekcBillFood(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getlistinterestwithroom(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .getlistinterestMovieRoom(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
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
        case .Moive(let page, let limit, let status, let Idcategory,let dateFrom,let dateTo):
            return ["offset_value":page,
                    "page_size":limit,
                    "status": status,
                    "Idcategory": Idcategory,
                    "dateFrom": dateFrom,
                    "dateTo": dateTo
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
                    "Idmovie" : idmovie
            ]
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
        case .getListAutoInterest(let roomlist,let  movieList,let dayStart,let dayEnd,let breakTime):
            return [
                "dayStart": dayStart,
              "dayEnd": dayEnd,
                "breakTime": breakTime,
              "movieList": movieList.toJSON(),
              "roomList": roomlist.toJSON()
            ]
        case .getListInterestsMovie(let idcinema,let idroom,let date):
            return [
                "idcinema":idcinema,
                "idroom":idroom,
                "date": date
            ]
            case .postListInterest(let roomlist,let  movieList,let dayStart,let dayEnd, let resetTime):
            return [
            "dayStart": dayStart,
            "dayEnd": dayEnd,
            "breakTime": resetTime,
            "movieList": movieList.toJSON(),
            "roomList": roomlist.toJSON()
            ]
        case .getListChairRoom(let Idroom):
            return ["Idroom":Idroom]
        case .getListCategoryChair:
            return [:]
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
                "foodComboBills": foodcombobill.foodComboBills.toJSON(),
                "idvoucher": foodcombobill.idvoucher
            ]
        case .getListBillinAccount(let iduser,let status):
            return [
                "status":status,
                "iduser": iduser
            ]
        case .getListBillFoodCombo(let iduser,let statusfoodbill):
            return ["iduser":iduser,"statusfoodbill":statusfoodbill]
        case .getListAllBill(let idcinema,let status,let datefrom,let dateto):
            return [
                "idcinema":idcinema,
                "status": status,
                "datefrom": datefrom,
                "dateto":dateto
            ]
        case .getListAllBillFoodCombo(let idcinema, let status,let datefrom,let dateto):
            return [
                "idcinema": idcinema,
                "status": status,
                "datefrom": datefrom,
                "dateto": dateto
            ]
        case .updateSatus(let idinterest,let status):
            return [
                "idinterest": idinterest,
                "status": status
            ]
        case .updateInterestMovie(let idinterest, let idmovie):
            return [
                "idinterest": idinterest,
                 "idmovie": idmovie
               
            ]
        case .getListMovieWithResetTime(let breakTime):
           return [
                "timereset": breakTime
            ]
        case .getListNation:
            return [
                :
            ]
        case .getListCategoryMovie:
            return [
                :
            ]
        case .CreateMovie(let movievalue,let videousers):
          return  [
                "namemovie": movievalue.namemovie,
                "author": movievalue.author,
                "yearbirthday": movievalue.yearbirthday,
                "idcategorymovie": movievalue.idcategory,
                "idnation": movievalue.idnation,
                "timeall": movievalue.timeall,
                "describes": movievalue.describes,
                "poster": movievalue.poster,
                "videofile": videousers.videofile,
                "iduser": videousers.iduser,
                "types": videousers.types
                
            ]
        case .UpdateMovie(let movievalue,let videousers):
            return [
                "idmovie": movievalue.movieID,
                "namemovie": movievalue.namemovie,
                "author": movievalue.author,
                "yearbirthday": movievalue.yearbirthday,
                "idcategorymovie": movievalue.idcategory,
                "idnation": movievalue.idnation,
                "timeall": movievalue.timeall,
                "describes": movievalue.describes,
                "poster": movievalue.poster,
                "videofile": videousers.videofile,
                "iduser": videousers.iduser,
                "types": videousers.types
            ]
        case .UpdateStatusMovie(let idmovie,let status):
            return [
                "idmovie": idmovie,
                "status":status
            ]
        case .GetListCategoryChairInRoom(let idroom):
            return [
                "idroom":idroom
            ]
        case .CreateCategoryChair(let categoryinfo):
            return [
                "price": categoryinfo.price,
                "namecategory": categoryinfo.namecategorychair,
                "colorchair": categoryinfo.colorchair,
                "idroom": categoryinfo.idroom
            ]
        case .getDetailInfoCategoryChair(let idcategory):
            return [
                "idcategory":idcategory
            ]
        case .updateCategoryInChairRoom(let listchair):
            return [
                "idcategory": listchair.idcategory,
                "listchair": listchair.listchair.toJSON()
            ]
        case .updateInfoCategoryChair(let infocategory):
            return [
                "idcategoryChair": infocategory.idcategoryChair,
                "price": infocategory.price,
                "namecategory": infocategory.namecategory,
                "colorchair": infocategory.colorchair,
                "idroom": infocategory.idroom,
                "nameroom": infocategory.nameroom
             ]
        case .getDetailBillInManager(let idbill):
            return [
                "idbill": idbill
            ]
        case .createNewVoucher(let vouchers):
            return [
                "idvoucher": vouchers.idvoucher,
                "namevoucher": vouchers.namevoucher,
                "price": vouchers.price,
                "percent": vouchers.percent,
                "note": vouchers.note,
                "poster": vouchers.poster
            ]
        case .getDetailVoucher(let idvoucher):
            return [
                "Idvoucher": idvoucher
            ]
        case .UpdateDetailVoucher(let vouchers):
            return [
                "idvoucher": vouchers.idvoucher,
                "namevoucher": vouchers.namevoucher,
                "price": vouchers.price,
                "percent": vouchers.percent,
                "note": vouchers.note,
                "poster": vouchers.poster
                
            ]
        case .createFoodNew(let food):
            return [
                "idfood": food.idfood,
                "namefood": food.namefood,
                "quantityfood": food.quantityfood,
                "picture": food.picture,
                "pricefood": food.pricefood,
                "idcategoryfood": food.idcategoryfood,
                "datecreate": "2023-09-27T15:46:39.033Z"
            ]
        case .getDetailfood(let idfood):
            return [
                "idfood":idfood
            ]
        case .updateinfodetailfood(let food):
            return [
                "idfood": food.idfood,
                "namefood": food.namefood,
                "quantityfood": food.quantityfood,
                "picture": food.picture,
                "pricefood": food.pricefood,
                "idcategoryfood": food.idcategoryfood,
                "datecreate": "2023-10-28T16:31:56.834Z",
                "namecategoryfood": "string"
            ]
        case .GetReportTicket(let report_type):
            return [
                "report_type": report_type
            ]
        case .ReportMovie(let report_type):
            return [
                "report_type": report_type
            ]
        case .reportFood(let report_type):
            return [
                "report_type": report_type
            ]
        case .reportDetailAll:
            return [:]
        case .paymentVNPAY(let amount,let idorder):
            return [
                "amount":amount,
                "idorder":idorder,
                "urlpayment":""
            ]
        case .getIdbillPayment(let idbill):
            return [
                "idbill":idbill
            ]
        case .getOTPInEmail(let emails):
            return [
                "emails":emails
            ]
        case .confrimOTP(let emails ,let enteredOTP,let username,let passwords,let fullname):
            return [
                "enteredOTP": enteredOTP,
                "username": username,
                 "passwords": passwords,
                 "fullname": fullname,
                 "emails": emails
            ]
        case .getListMovieBooking(let status):
            return [
                "statusshow":status
            ]
        case .getcheckaccountExistsSigin(let username):
            return [
                "username":username
            ]
        case .getForgotPassword(let username):
            return [
                "username":username
            ]
        case .confirmfogotAccount(let emails,let enteredOTP,let iduser):
            return [
                "emails": emails,
                "enteredOTP": enteredOTP,
                "iduser": iduser
            ]
        case .changepassword(let newpassword,let username):
            return [
                "newpassword":newpassword,
                "username":username
            ]
        case .saveCacheVNPAY(let bill):
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
        case .getDetailInfoCinema(let idcinema):
            return [
                "idcinema":idcinema
            ]
        case .getNoTiFaction(let iduser):
            return [
                "iduser":iduser
            ]
        case .getUpdateCinemaInfo(let datacinema):
            return [
                "idcinema": datacinema.idcinema,
                "namecinema": datacinema.namecinema,
                "address": datacinema.address,
                "phone": datacinema.phone,
                "picture": datacinema.picture,
                "describes": datacinema.describes
             ]
        case .saveCacheBillFood(let datapaymentBillfood):
            return [
                "id": 0,
                "idFoodcombo": datapaymentBillfood.idFoodcombo,
                "idFoodlistcombo": 0,
                "numbers": datapaymentBillfood.numbers,
                "total_price": datapaymentBillfood.total_price,
                "iduser": datapaymentBillfood.iduser,
                "idcinemas": datapaymentBillfood.idcinemas,
                "foodComboBills": datapaymentBillfood.foodComboBills.toJSON(),
                "idvoucher": datapaymentBillfood.idvoucher
            ]
        case .createLinkVNPAYBILLFOODCOMBO(let amount,let idorder):
            return [
                "amount":amount,
                "idorder":idorder,
                "urlpayment":""
            ]
        case .chekcBillFood(let idbill):
            return [
                "idbill":idbill
            ]
        case .getlistinterestwithroom(let date,let idroom):
            return [
                "date":date,
                "idroom":idroom
            ]
        case .getlistinterestMovieRoom(let date,let idroom):
            return [
                "date":date,
                "idroom":idroom
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
        dLog(headers ?? "")
        switch self {
         
        case .Login(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .config(_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .Moive(_,_,_,_,_,_):
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
        case .getListAutoInterest(_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListInterestsMovie(_,_,_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .postListInterest(_,_,_,_,_):
             return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListChairRoom(_):
              return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListCategoryChair:
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
        case .getListBillinAccount(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListBillFoodCombo(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListAllBill(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListAllBillFoodCombo(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .updateSatus(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .updateInterestMovie(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListMovieWithResetTime(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListNation:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getListCategoryMovie:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .CreateMovie(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .UpdateMovie(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .UpdateStatusMovie(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .GetListCategoryChairInRoom(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .CreateCategoryChair(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getDetailInfoCategoryChair(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .updateCategoryInChairRoom(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .updateInfoCategoryChair(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getDetailBillInManager(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .createNewVoucher(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getDetailVoucher(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .UpdateDetailVoucher(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .createFoodNew(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getDetailfood(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .updateinfodetailfood(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .GetReportTicket(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .ReportMovie(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .reportFood(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .reportDetailAll:
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .paymentVNPAY(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getIdbillPayment(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getOTPInEmail(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .confrimOTP(_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getListMovieBooking(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getcheckaccountExistsSigin(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getForgotPassword(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .confirmfogotAccount(_,_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .changepassword(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .saveCacheVNPAY(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .getDetailInfoCinema(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getNoTiFaction(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getUpdateCinemaInfo(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .saveCacheBillFood(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .createLinkVNPAYBILLFOODCOMBO(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.post))
        case .chekcBillFood(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getlistinterestwithroom(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .getlistinterestMovieRoom(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
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
