//
//  FireBaseManager.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import JonAlert

final class FireBaseManager {
    static let shared = FireBaseManager()
    
    private let database = Database.database().reference()
    
    
  
    
   
}
struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var imageProfile: String{
        return "\(safeEmail)_profile_picture.png"
    }
}
//CALL MARK: ACCOUNT MANAGER
extension FireBaseManager {
    public func userExists(with email: String,
                           completion: @escaping (Bool) -> Void)
    {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    public func test() {
        database.child("foo").setValue(["somthing": true])
        
    }
    
    public func insertUser(with user: ChatAppUser, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ], withCompletionBlock: {error,_ in
            guard error == nil else {
                dLog("faield to write to database")
                completion(true)
                return
            }
        })
    }
}

extension FireBaseManager {
    func createUser(email: String, password: String, imageView: UIImage) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")

        userExists(with: safeEmail) { [weak self] exists in
            guard let strongSelf = self else {
                return
            }

            guard !exists else {
                JonAlert.showError(message: "User Already exists")
                return
            }

            do {
                try FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard let result = authResult, error == nil else {
                        dLog("Error firebase: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }

                    let chatUser = ChatAppUser(firstName: ManageCacheObject.getCurrentUser().username, lastName: ManageCacheObject.getCurrentUserInfo().fullname, emailAddress: safeEmail)

                    FireBaseManager.shared.insertUser(with: chatUser) { success in
                        guard let data = imageView.pngData() else {
                            return
                        }

                        let filename = chatUser.imageProfile

                        StorageManager.shared.uploadProfilePicture(with: data, fileName: filename) { result in
                            switch result {
                            case .success(let downloadurl):
                                UserDefaults.standard.set(downloadurl, forKey: "profile_picture_url")
                                dLog(downloadurl)
                            case .failure(let error):
                                dLog(error)
                            }
                        }
                    }

                    let user = result.user
                    dLog("create user: \(user)")
                }
            } catch {
                dLog("Error creating user: \(error.localizedDescription)")
            }
        }
    }

    func LoginUser(email:String,password:String,username:String) {
       
        
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {
            authReust, error in
            guard let result = authReust, error == nil else {
                dLog("Error firebase: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
       
            let user = result.user
            dLog("login usser: \(user)")
        })
    }
}
