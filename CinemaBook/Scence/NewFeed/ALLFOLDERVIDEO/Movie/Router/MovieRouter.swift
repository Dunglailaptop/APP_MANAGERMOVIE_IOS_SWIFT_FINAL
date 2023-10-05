//
//  MovieRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class MovieRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = MovieViewController(nibName: "MovieViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?) {
        guard let view = sourceView else {fatalError("Error")}
        self.sourceView = view
    }
    
   
     
  
}
