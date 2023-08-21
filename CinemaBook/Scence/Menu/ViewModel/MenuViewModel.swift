
//
//  LoginViewModel.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//

import UIKit
import RxSwift


class MenuViewModel {
    
    private(set) weak var view: MenuViewController?
    private var router: MenuRouter?
    private let disposeBag = DisposeBag()

    
    func bind(view: MenuViewController, router: MenuRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
  
    
}
extension MenuViewModel {
  
    
}
