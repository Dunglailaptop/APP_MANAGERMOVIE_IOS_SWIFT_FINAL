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

final class FireBaseManager {
    static let shared = FireBaseManager()
    
    private let database = Database.database().reference()
    
   
    
   
}
struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
}
//CALL MARK: ACCOUNT MANAGER
extension FireBaseManager {
    public func userExists(with email: String,
                           completion: @escaping (Bool) -> Void)
    
    public func test() {
        database.child("foo").setValue(["somthing": true])
        
    }
    
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

extension FireBaseManager {
    func createUser(email:String,password:String) {
     
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {
            authReust, error in
            guard let result = authReust, error == nil else {
                dLog("Error firebase: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let user = result.user
            dLog("create usser: \(user)")
        })
    }
    func LoginUser(email:String,password:String) {
     
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {
            authReust, error in
            guard let result = authReust, error == nil else {
                dLog("Error firebase: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self.insertUser(with: ChatAppUser(firstName: ManageCacheObject.getCurrentUser().username, lastName: ManageCacheObject.getCurrentUserInfo().fullname, emailAddress: ManageCacheObject.getCurrentUserInfo().email))
            let user = result.user
            dLog("login usser: \(user)")
        })
    }
}
