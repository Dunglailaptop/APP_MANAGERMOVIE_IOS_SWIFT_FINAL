//
//  HandlerDelegate.swift
//  myapp
//
//  Created by macmini_techres_04 on 22/06/2023.
//

import Foundation


protocol ChooseCityDelegate {
    func callbackchoosecity(city: String)
}

protocol  LogoutConfirm {
    func callbackAccessConfirm()
}

protocol DialogAccessEmployee {
    func callbackDialogAccess(id:Int,status:Int)
}
protocol DialogListPopupInterestMovie {
    func callbackDialogListMovie(Movies:[Movie])
}
protocol  DialogListPopupInterestRoom {
    func callbackDialogListRoom(Rooms:[Room])
}
