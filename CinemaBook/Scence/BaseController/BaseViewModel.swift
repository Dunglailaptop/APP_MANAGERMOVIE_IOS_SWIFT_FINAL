//
//  BaseViewModel.swift
//  TechresOrder
//
//  Created by Kelvin on 13/01/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import Moya

class BaseViewModel {
    
  
    
    // Dispose Bag
    

    // Dispose Bag
    let disposeBag = DisposeBag()
    
 
  

    let errorHandler: ((Error) -> Void)? = {err in
        dLog(err)
    }

    let progressHandler: ((Double) -> Void)? = {err in
        dLog(err)
    }
    
}
extension BaseViewModel{
    
    
   
}

