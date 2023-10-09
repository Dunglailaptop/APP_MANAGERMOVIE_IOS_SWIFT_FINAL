//
//  PaymentBillRouter.swift
//  CinemaBook
//
//  Created by dungtien on 10/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//


import UIKit

class PaymentBillRouter {
    var viewController: UIViewController {
           return createViewController()
       }
       
       private var sourceView:UIViewController?
       
       private func createViewController() -> UIViewController {
           let view = PaymentBillViewController(nibName: "PaymentBillViewController", bundle: Bundle.main)
           return view
       }
       
       func setSourceView(_ sourceView:UIViewController?) {
           guard let view = sourceView else {fatalError("Error")}
           self.sourceView = view
       }
    
    func makePopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func makePopToViewControllerSuccessPayment(){
        sourceView?.navigationController?.popViewController(animated: false)
    }
    func makeToBookingChairView(){
        let viewBookingChair = BookingChairRouter().viewController
        sourceView?.navigationController?.pushViewController(viewBookingChair, animated: true)
        
    }
  
}
