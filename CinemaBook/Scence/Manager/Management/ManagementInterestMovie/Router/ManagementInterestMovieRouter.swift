//
//  ManagementInterestMovieRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/15/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit

class ManagementInterestMovieRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementInterestMovieViewController(nibName: "ManagementInterestMovieViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigationPopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
  
}


