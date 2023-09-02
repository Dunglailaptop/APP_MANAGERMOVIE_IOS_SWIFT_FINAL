//
//  videoShortRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class videoShortRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = videoShortViewController(nibName: "videoShortViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?) {
        guard let view = sourceView else {fatalError("Error")}
        self.sourceView = view
    }
    
   
    func navigationToDetailVideoShortViewController() {
        let DetailVideoShortViewController = DetailVideoShortRouter().viewController
        sourceView?.navigationController?.pushViewController(DetailVideoShortViewController, animated: true)
    }
  
}
