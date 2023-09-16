//
//  ManageCacheObject.swift
//  SEEMT
//
//  Created by macmini_techres_04 on 12/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import ObjectMapper

class  ManageCacheObject{

    // lưu xuống bộ nhớ cache của máy
    static func saveCache(_ config: Config) {
        UserDefaults.standard.set(Mapper<Config>().toJSON(config), forKey: Constans.KEY_DEFAULT_STORAGE.key_config)
    }
//
    //config
    //setconfig
    static func setConfig(_ config: Config) {
        UserDefaults.standard.set(Mapper<Config>().toJSON(config),
                                  forKey: Constans.KEY_DEFAULT_STORAGE.key_config)

    }
    static func getConfig() -> Config {
        if let config = UserDefaults.standard.object(forKey: Constans.KEY_DEFAULT_STORAGE.key_config){
            return Mapper<Config>().map(JSONObject: config)!
        }else {
            return Config.init()
        }
    }
    //LAY CỘT PUSH TOKEN TRÊN API
    static func getPushtoken() -> String {
        if let push_token : String = UserDefaults.standard.object(forKey: Constans.KEY_DEFAULT_STORAGE.KEY_PUSH_TOKEN) as? String{
            return push_token
            
        }else{
            return ""
        }
            
    }
    
    static func getUsername() -> String{
        if let username = UserDefaults.standard.object(forKey: Constans.KEY_DEFAULT_STORAGE.KEY_PHONE){
            return String(username as! String)
        }else {
            return ""
        }
    }
    static func getPassword()-> String {
        if let password = UserDefaults.standard.object(forKey: Constans.KEY_DEFAULT_STORAGE.KEY_PHONE) {
            return String(password as! String)
            
        }else {
            return ""
        }
    }
    // lay id nhan vien
    static func getCurrentUser() -> Account {
        if let user = UserDefaults.standard.object(forKey: Constans.KEY_DEFAULT_STORAGE.key_account){
            return Mapper<Account>().map(JSONObject: user)!
        }else{
            return Account.init()
        }
    }
    static func saveCurrentUser(_ user : Account) {
        UserDefaults.standard.set(Mapper<Account>().toJSON(user), forKey:
                                    Constans.KEY_DEFAULT_STORAGE.key_account)

    }
    
    // lay thong tin nhan vien
    static func getCurrentUserInfo() -> Users {
        if let user = UserDefaults.standard.object(forKey: Constans.KEY_DEFAULT_STORAGE.key_account){
            return Mapper<Users>().map(JSONObject: user)!
        }else{
            return Users.init()
        }
    }
    static func saveCurrentUserInfo(_ user : Users) {
        UserDefaults.standard.set(Mapper<Users>().toJSON(user), forKey:
            Constans.KEY_DEFAULT_STORAGE.key_account)
        
    }
    
    // lay thong tin cinema
       static func getCurrentCinema() -> Cinema {
           if let user = UserDefaults.standard.object(forKey: Constans.KEY_DEFAULT_STORAGE.KEY_PHONE){
               return Mapper<Cinema>().map(JSONObject: user)!
           }else{
               return Cinema.init()
           }
       }
       static func saveCurrentCinema(_ cinema : Cinema) {
           UserDefaults.standard.set(Mapper<Cinema>().toJSON(cinema), forKey:
               Constans.KEY_DEFAULT_STORAGE.KEY_PHONE)
           
       }
    
    static func isLogin()->Bool{
        let account = ManageCacheObject.getCurrentUserInfo()
        if(account.idusers == 0){
            return false
        }
        return true
    }
    
}
