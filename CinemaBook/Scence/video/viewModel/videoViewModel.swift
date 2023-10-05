//
//  videoViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 8/23/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class videoViewModel: BaseViewModel {
    private(set) weak var view: VideoViewController?
    private var router: videoRouter?
    
    func bind(view: VideoViewController,router: videoRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceview(view)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
}
