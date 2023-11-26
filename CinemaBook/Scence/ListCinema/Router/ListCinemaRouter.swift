//
//  ListCinemaRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 26/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ListCinemaRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ListCinemaViewController(nibName: "ListCinemaViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    func makePopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
    func makeToDetailCinemaViewController(idcinema:Int) {
        let viewDetailCinema = ListInfoCinemaRouter().viewController as! ListInfoCinemaViewController
        viewDetailCinema.idcinema = idcinema
        sourceView?.navigationController?.pushViewController(viewDetailCinema, animated: true)
    }

    
}
