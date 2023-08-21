
//
//  SplashScreenViewModel.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 14/01/2023.
//

import UIKit

class SplachScreenViewModel{
    private(set) weak var view: SplachScreenViewController?
    private var router: SplashScreenRouter?
    
    
    func bind(view: SplachScreenViewController, router: SplashScreenRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLoginViewController(){
        router?.navigateToLoginViewController()
    }
    
    func makeMainViewController(){
        router?.navigateToMainViewController()
    }
    
}
