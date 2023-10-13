//
//  StoreRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class StoreRouter {
    var viewController:UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = StoreViewController(nibName: "StoreViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceview(_ sourceview:UIViewController?){
        guard let view = sourceview else {fatalError("error")}
        self.sourceView = view
    }
    
    func makePopToViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    func makeToProductComboViewController(){
        let viewProductCombo = DetailProductRouter().viewController
        sourceView?.navigationController?.pushViewController(viewProductCombo, animated: true)
    }
    
    func makeToPopStoreViewController() {
        let viewStoreViewController = CartRouter().viewController
        sourceView?.navigationController?.pushViewController(viewStoreViewController, animated: true)
    }
   
}
