//
//  ManagementRoomViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementRoomViewModel: BaseViewModel {
    private(set) weak var view: ManagementRoomViewController?
    private var router: ManagementRoomRouter?
  
    func bind(view: ManagementRoomViewController, router: ManagementRoomRouter){
          self.view = view
          self.router = router
          self.router?.setSourceView(self.view)
      }
}

