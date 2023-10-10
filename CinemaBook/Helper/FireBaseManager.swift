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
    
    static func safeEmail(email:String) -> String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
  
    
   
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
                           completion: @escaping (Bool) -> Void) -> Bool
    {
        var check = true
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                check = false
               return completion(false)
                
            }
            completion(true)
            check = true
            return completion(true)
        })
        return check
    }
    
    public func test() {
        database.child("foo").setValue(["somthing": true])
        
    }
    
    public func insertUser(with user: ChatAppUser, completion: @escaping (Bool) -> Void) -> Bool {
        var check = true
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ], withCompletionBlock: {error,_ in
            guard error == nil else {
                dLog("faield to write to database")
                completion(false)
                check = false
                return
            }
        })
        return check
    }
}

extension FireBaseManager {
    func checkExists(email: String, password: String, imageView: UIImage) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")

   if  userExists(with: safeEmail) { [weak self] exists in
            guard let strongSelf = self else {
                return
            }

            guard !exists else {
                JonAlert.showError(message: "User Already exists")
                return
            }

          
        }
        {
            createUser(email: email, password: password,imageView: imageView)
        }
       
        
      
    }
    
    
    func createUser(email: String, password: String,imageView:UIImage) {
      
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
               guard let result = authResult, error == nil else {
                   dLog("Error firebase: \(error?.localizedDescription ?? "Unknown error")")
                   return
               }

             

           

               let user = result.user
               dLog("create user: \(user)")
           }
          insertUsers( safeEmail: email, imageView: imageView)
       
       
    }
    
    func insertUsers(safeEmail:String,imageView: UIImage) {
       
            let chatUser = ChatAppUser(firstName: ManageCacheObject.getCurrentUser().username, lastName: ManageCacheObject.getCurrentUserInfo().fullname, emailAddress: safeEmail)
       if   FireBaseManager.shared.insertUser(with: chatUser) { success in
            
            }
        {
            uploadImageWithUser( safeEmail: safeEmail, imageView: imageView)
        }
         
      
      
    }
    
    func uploadImageWithUser(safeEmail:String,imageView: UIImage) {
     
            let chatUser = ChatAppUser(firstName: ManageCacheObject.getCurrentUser().username, lastName: ManageCacheObject.getCurrentUserInfo().fullname, emailAddress: safeEmail)
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

    func LoginUser(email:String,password:String,username:String) {
       
        
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {
            authReust, error in
            guard let result = authReust, error == nil else {
                dLog("Error firebase: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
       
            let user = result.user
            
            UserDefaults.standard.set(email, forKey: "email")
            
            dLog("login usser: \(user)")
        })
    }
    
    func getImageUser(imageview: UIImageView) {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        let safeEmail = FireBaseManager.safeEmail(email: email)
        let Filename = safeEmail + "_profile_picture.png"
        let path = "images/" + Filename
        
        StorageManager.shared.downloadURL(for: path, completion: {
            Result in
            switch Result {
            case .success(let url):
                self.downloadImage(imageView: imageview, urlString: path)
            case .failure(let error):
                   dLog("faile to get download url: \(error)")
            }
        })
    }
    
    func downloadImage(imageView: UIImageView, urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        imageView.image = image
                    }
                }
            }).resume()
        }
    }

}
