//
//  ManagemetnDetailMovieRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 21/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagemetDetailMovieRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementDetailMovieViewController(nibName: "ManagementDetailMovieViewController", bundle: Bundle.main)
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


