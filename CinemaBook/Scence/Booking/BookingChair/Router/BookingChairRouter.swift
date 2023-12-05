//
//  BookingChairRouter.swift
//  CinemaBook
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class BookingChairRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = BookingChairViewController(nibName: "BookingChairViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?) {
        guard let view = sourceView else {fatalError("Error")}
        self.sourceView = view
    }
    func makePopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
    func makeToBookingProductComboViewController(dataInfoMovieS: InfoInterestMovie,dataChairs:[chair]) {
        let viewBookingProductCombo = BookingProductComboRouter().viewController as! BookingProductComboViewController
        viewBookingProductCombo.dataInfoMovie = dataInfoMovieS
        viewBookingProductCombo.dataChair = dataChairs
        sourceView?.navigationController?.pushViewController(viewBookingProductCombo, animated: true)
    }
    func makeToDetailBillViewController(idbill:Int) {
        let viewdetailbill = ManagementDetailBillRouter().viewController as! ManagementDetailBillViewController
        viewdetailbill.bill = idbill
        sourceView?.navigationController?.pushViewController(viewdetailbill, animated: true)
    }
    
}

