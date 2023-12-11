//
//  BookingProductComboRouter.swift
//  CinemaBook
//
//  Created by dungtien on 10/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class BookingProductComboRouter {
    var viewController: UIViewController {
           return createViewController()
       }
       
       private var sourceView:UIViewController?
       
       private func createViewController() -> UIViewController {
           let view = BookingProductComboViewController(nibName: "BookingProductComboViewController", bundle: Bundle.main)
           return view
       }
       
       func setSourceView(_ sourceView:UIViewController?) {
           guard let view = sourceView else {fatalError("Error")}
           self.sourceView = view
       }
    
    func makePopToViewController() {
        sourceView?.navigationController?.popViewController(animated: false)
    }
  
    func makeToPaymentViewController(dataChairs:[chair],infoInterestMovie:InfoInterestMovie,dataFoodCombo:[FoodCombo]) {
        let viewPayment = PaymentBillRouter().viewController as! PaymentBillViewController
        viewPayment.dataChair = dataChairs
        viewPayment.infoInterestMovie = infoInterestMovie
        viewPayment.dataFoodCombo = dataFoodCombo
        viewPayment.callPopViewController = makePopToViewController
        sourceView?.navigationController?.pushViewController(viewPayment, animated: true)
    }
}
