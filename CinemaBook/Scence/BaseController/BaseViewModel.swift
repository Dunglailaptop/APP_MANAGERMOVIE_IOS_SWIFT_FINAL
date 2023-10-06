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
import AVKit

class BaseViewModel {
    
  
    
    // Dispose Bag
    

    // Dispose Bag
    let disposeBag = DisposeBag()
    public var media_request: BehaviorRelay<[Medias]> = BehaviorRelay(value: [])
    public var image_request: BehaviorRelay<String> = BehaviorRelay(value: "")
 
    
    let serverUrl = URL(string: "http://localhost:5062/Phim/UploadImage")!
    let headers: HTTPHeaders = [:]

    
    let errorHandler: ((Error) -> Void)? = {err in
        dLog(err)
    }

    let progressHandler: ((Double) -> Void)? = {err in
        dLog(err)
    }
    
}
extension BaseViewModel{


//  func uploadImage(){
//      let dataImage = media_request.value
//
//      AF.upload(
//          multipartFormData: { multipartFormData in
//              for i in 0..<dataImage.count {
//                  if let imageData = dataImage[i].image!.jpegData(compressionQuality: 0.5){
//                    dLog(dataImage[0].name)
//                    multipartFormData.append(imageData, withName: "files", fileName: dataImage[0].name!, mimeType: "file")
//                  }
//              }
//          },
//          to: serverUrl,
//          method: .post,
//          headers: headers
//      ) { encodingResult in
//      switch encodingResult {
//      case .success(let upload, _, _):
//          upload.responseJSON { response in
//              switch response.result {
//              case .success(let value):
//                  // Check the HTTP status code
//                  if let statusCode = response.response?.statusCode {
//                      if (200..<300).contains(statusCode) {
//                          // Handle success
//                          dLog("Upload successful. Status code: \(statusCode)")
//                          // You can parse 'value' if it contains JSON data
//                          if let json = value as? [String: Any], let message = json["message"] as? String {
//                              dLog("Response message: \(message)")
//                            self.image_request.accept(message)
//
//
//                              // You can use the 'message' here
//                          }
//                      } else {
//                          // Handle server error with non-2xx status code
//                          dLog("Server error. Status code: \(statusCode)")
//                          dLog("Response JSON: \(value)")
//                          // You can further parse 'value' for error details
//                      }
//                  } else {
//                      // Handle unexpected response
//                      dLog("Unexpected response")
//                  }
//
//              case .failure(let error):
//                  dLog("Error: \(error.localizedDescription)")
//                  // Handle failure
//              }
//          }
//      case .failure(let encodingError):
//          dLog("Multipart encoding error: \(encodingError)")
//          // Handle encoding error
//      }
//
//      }
//
//  }


    func uploadImage() {
        let dataImage = media_request.value
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for i in 0..<dataImage.count {
                    if let imageData = dataImage[i].image?.jpegData(compressionQuality: 0.5) {
                        dLog(dataImage[i].name)
                        multipartFormData.append(imageData, withName: "files", fileName: dataImage[i].name ?? "defaultFileName", mimeType: "file")
                    }
                }
            },
            to: serverUrl,
            method: .post,
            headers: headers
        )
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let statusCode = response.response?.statusCode {
                    if (200..<300).contains(statusCode) {
                        dLog("Upload successful. Status code: \(statusCode)")
                        if let json = value as? [String: Any], let message = json["message"] as? String {
                            dLog("Response message: \(message)")
                            self.image_request.accept(message)
                        }
                    } else {
                        dLog("Server error. Status code: \(statusCode)")
                        dLog("Response JSON: \(value)")
                    }
                } else {
                    dLog("Unexpected response")
                }
            case .failure(let error):
                dLog("Error: \(error.localizedDescription)")
            }
        }
    }


    
   
}

