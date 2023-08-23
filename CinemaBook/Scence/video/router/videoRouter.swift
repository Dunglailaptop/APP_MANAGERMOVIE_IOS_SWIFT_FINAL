//
//  videoRouter.swift
//  CinemaBook
//
//  Created by dungtien on 8/23/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class videoRouter {
    var viewController:UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = VideoViewController(nibName: "VideoViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceview(_ sourceview:UIViewController?){
        guard let view = sourceview else {fatalError("error")}
        self.sourceView = view
    }
    
    func makePopToViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
   
}
