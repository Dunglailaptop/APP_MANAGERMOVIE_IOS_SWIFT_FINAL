//
//  SplachScreenViewController.swift
//  CinemaBook
//
//  Created by dungtien on 7/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class SplachScreenViewController: BaseViewController {

   private var viewModel = SplachScreenViewModel()
   private var router = SplashScreenRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        if(ManageCacheObject.isLogin()){
            dLog("Ready login...")
            viewModel.makeMainViewController()
        }else{
            dLog("Not Login...")
            viewModel.makeLoginViewController()
        }
    }


    

}
