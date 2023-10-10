//
//  StorageBaseManager.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: { meta, error in
            guard error == nil else {
                dLog("FAILED TO UPLOAD IMAGE")
                completion(.failure(StorageError.failedToUpload))
                return
            }
            let reference = self.storage.child("images/\(fileName)").downloadURL(completion: { url,error in
                guard let url = url else {
                    dLog("Fail to get download url")
                    completion(.failure(StorageError.failedToGetDownLoadUrl))
                    return
                }
                let urlString = url.absoluteString
                dLog("download url returnd: \(urlString)")
                completion(.success(urlString))
            })
        } )
    }
    
            public enum StorageError: Error {
                case failedToUpload
                case failedToGetDownLoadUrl
            }
    
    public func downloadURL(for path: String,  completion: @escaping (Result<URL, Error>) -> Void){
        let reference = storage.child(path)
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageError.failedToGetDownLoadUrl))
                return
            }
            completion(.success(url))
        })
    }
}
