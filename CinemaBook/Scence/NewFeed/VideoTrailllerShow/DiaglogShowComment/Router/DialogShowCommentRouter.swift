//
//  DialogShowCommentRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 28/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class DialogShowCommentRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = DialogShowCommentViewController(nibName: "DialogShowCommentViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?) {
        guard let view = sourceView else {fatalError("Error")}
        self.sourceView = view
    }
    
   
   
  
}
