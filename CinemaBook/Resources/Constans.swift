//
//  Constans.swift
//  SEEMT
//
//  Created by macmini_techres_04 on 12/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
struct Constans {
    static let apikey = "net.techres.tms.api"
    
    static let hashcode = "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI5MWUxOWQ0Yi1lNmU3LTRjMzctOGEzMC0wMGU4NjE4ZjEzNTMiLCJpYXQiOjE2Njc2MTM4NzQsInN1YiI6IjMiLCJpc3MiOiJURUNIUkVTIiwiZXhwIjoxNjgzMTY1ODc0LCJ1c2VyX2lkIjoiODI1ODYiLCJjdXJyZW50X3RpbWVzdGFtcCI6MTY2NzYxMzg3NDM0MX0.U_6otx5NGnXGxEyrEXb9xERrCtRwhogWaMyjxLNiUho"
    
    static let hashcode2 = "30ff0d44-741d-434c-ad2c-ac7ab80f51d1"
    static let hashcode3 = "9ca40792-2582-404f-82fe-ab4a0bb816fb"
    static let hashcode4 = "34e1d8af-6389-42c6-a4f0-8fb9b28ec15a"
    
    struct PROJECT_IDS {
        static let PROJECT_OAUTH = 8097
        static let PROJECT_ID_SEEMT = 8093
        static let PROJECT_ID_CONVERSION = 7012
        static let PROJECT_ID_TECHORDER = 8094
        static let PROJECT_ID_FOOD = 8197
    }
    struct METHOD {
        static let POST = "POST"
        static let GET = "GET"
    }
    struct KEY_DEFAULT_STORAGE {
        static let key_account = "KEY_ACCOUNT"
        static let key_config = "KEY_CONFIG"
        static let KEY_PUSH_TOKEN = "KEY_PUSH_TOKEN"
        static let KEY_PHONE = "KEY_PHONE"
        
    }
    
    struct KEY_LOGIN_REQUID {
        static let minlengthkey = 2
        static let lengthkey = 25
        static let lengthacc = 10
    }
    
    struct METHOD_TYPE {
        static let GET = 0
        static let POST = 1
    }
    
}
