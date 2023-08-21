//
//  BookingRouter.swift
//  CinemaBook
//
//  Created by dungtien on 8/13/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class BookingRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = BookingTicketViewController(nibName: "BookingTicketViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?) {
        guard let view = sourceView else {fatalError("Error")}
        self.sourceView = view
    }
    
    func navigationMakeToDetailMovieViewController(id:Int){
        let DetailMovieViewController = DetailMovieRouter().viewController as! DetailMovieViewController
        DetailMovieViewController.idmovie = id
        sourceView?.navigationController?.pushViewController(DetailMovieViewController, animated: true)
    }
    
  
}
