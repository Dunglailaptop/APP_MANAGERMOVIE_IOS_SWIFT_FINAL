//
//  HomeRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class HomeRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = HomeViewController(nibName: "HomeViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigationToDetailViewController(idmovie:Int) {
        let DetailViewController = DetailMovieRouter().viewController as! DetailMovieViewController
        DetailViewController.idmovie = idmovie
        sourceView?.navigationController?.pushViewController(DetailViewController, animated: true)
    }
    
    func navigationToStoreProductViewController() {
        let storeProduct = StoreRouter().viewController
        sourceView?.navigationController?.pushViewController(storeProduct, animated: true)
    }
    
}


