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
    case Moive(page:Int,limit:Int)
    case MovieDetail(idmovie:Int)
    case UpdateAccount(iduser:Int,Fullname:String,Email:String,Phone:String,Birthday:String,avatar:String)
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
        case .Moive(let page,let limit):
            return APIEndPoint.Name.urlMovie
        case .MovieDetail(let idmovie):
             return APIEndPoint.Name.urlDetail
        case .UpdateAccount(_,_,_,_,_,_):
            return APIEndPoint.Name.urlUpdateAccount
        }
    
    }
    var method: Moya.Method {
        switch self {
        case .Login(_,_):
            return .get
        case .config(_):
            return .get
        case .Moive(_,_):
            return .get
        case .MovieDetail(_):
            return .get
        case .UpdateAccount(_,_,_,_,_,_):
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
        case .Moive(_,_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .MovieDetail(_):
            return headerJava(ProjectId: Constans.PROJECT_IDS.PROJECT_OAUTH, Method: Constans.METHOD_TYPE.GET)
        case .UpdateAccount(_,_,_,_,_,_):
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
        case .Moive(let page, let limit):
            return ["offset_value":page,
                    "page_size":limit
            ]
        case .MovieDetail(let idmovie):
            return ["Idmovie":idmovie]
        case .UpdateAccount(let iduser,let Fullname,let Email,let Phone, let Birthday,let avatar):
            return [
              "Idusers": iduser,
              "Fullname": Fullname,
              "Email": Email,
              "Phone": Phone,
              "Birthday": Birthday,
              "avatar": avatar
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
        case .Moive(_,_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .MovieDetail(_):
            return .requestParameters(parameters: parameters!, encoding: self.encoding(.get))
        case .UpdateAccount(_,_,_,_,_,_):
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

// Instantiate the NetworkLoggerPlugin
let networkLogger = NetworkLoggerPlugin(
    verbose: true, // Set to true for detailed logging, false otherwise
    cURL: false,   // Set to true to log requests and responses in cURL format
   
    requestDataFormatter: requestDataFormatter, // The closure to format request data
    responseDataFormatter: responseDataFormatter  // The closure to format response data
)









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
