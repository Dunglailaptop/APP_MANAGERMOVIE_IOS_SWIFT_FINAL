//
//  ManagementRoomRouter.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementRoomRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementRoomViewController(nibName: "ManagementRoomViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigationPopToViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigationToCreatRoomViewController() {
        let CreateRoomViewController = MangementRoomCreateRouter().viewController
        sourceView?.navigationController?.pushViewController(CreateRoomViewController, animated: true)
    }
    
    func navigationToManagementDetailRoom(room:Room) {
        let viewDetail = ManagementDetailRoomRouter().viewController as! ManagementDetailRoomViewController
        viewDetail.infoRoom = room
        sourceView?.navigationController?.pushViewController(viewDetail, animated: true)
    }
    
  
}
