//
//  TimeShowRouter.swift
//  CinemaBookTests
//
//  Created by dungtien on 8/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class TimeShowRouter {
    var viewController: UIViewController {
           return createViewController()
       }
       
       private var sourceView:UIViewController?
       
       private func createViewController() -> UIViewController {
           let view = TimeShowViewController(nibName: "TimeShowViewController", bundle: Bundle.main)
           return view
       }
       
       func setSourceView(_ sourceView:UIViewController?) {
           guard let view = sourceView else {fatalError("Error")}
           self.sourceView = view
       }
    
    func navigationToBookingChairViewController(idcinema:Int,idroom:Int,idinterest:Int) {
        let bookingchairview = BookingChairRouter().viewController as! BookingChairViewController
        bookingchairview.idcinema = idcinema
        bookingchairview.idroom = idroom
        bookingchairview.idinterest = idinterest
        sourceView?.navigationController?.pushViewController(bookingchairview, animated: true)
    }
    
    func makepopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
}
