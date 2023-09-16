//
//  ManagementMovieRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/14/23.
//  Copyright © 2023 dungtien. All rights reserved.
//


import UIKit

class ManagementMovieRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementMovieViewController(nibName: "ManagementMovieViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    func navigationPopViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
  
}
