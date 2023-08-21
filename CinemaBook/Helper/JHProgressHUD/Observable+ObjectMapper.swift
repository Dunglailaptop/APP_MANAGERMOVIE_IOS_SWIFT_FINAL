//
//  Observable+ObjectMapper.swift
//  SEEMT
//
//  Created by macmini_techres_04 on 12/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper



extension Observable {
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            
            guard let dict = response as? [String:Any] else {
                throw RxSwiftMoyaError.parseJSONError
            }
            return Mapper<T>().map(JSON: dict)!
        }
    }
    func mapArray<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.parseJSONError
            }
            
            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.parseJSONError
            }
            
            return Mapper<T>().mapArray(JSONArray: dicts) as! T
        }
    }
}

enum RxSwiftMoyaError: String {
    case parseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error {}
