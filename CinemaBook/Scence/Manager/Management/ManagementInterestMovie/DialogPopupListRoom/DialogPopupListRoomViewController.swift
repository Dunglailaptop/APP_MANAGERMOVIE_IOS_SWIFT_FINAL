//
//  DialogPopupListRoomViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/18/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class DialogPopupListRoomViewController: UIViewController {

    var viewModel = ManagementInterestMoviesViewModel()
    var delegate: DialogListPopupInterestRoom?
//    @IBOutlet weak var tableView: UITableView!
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        register()
//        bindingtableview()
      UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                           UIViewController.attemptRotationToDeviceOrientation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        
        
    }
    // Cho phép xoay cả hai hướng
           override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
               return .landscape
           }


            override var shouldAutorotate: Bool {
                return true
            }

            override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
                return .landscapeRight
            }

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_access(_ sender: Any) {
        dismiss(animated: true)
//        let data = viewModel.dataArrayRoom.value.filter{$0.ischeck == 1}
//        var datas = viewModel.pagationDataArray.value
//        dLog(data)
//        data.enumerated().forEach{(index,value) in
//            datas.Rooms.idroom = value.idroom
//        }
//        viewModel.pagationDataArray.accept(datas)
//        dLog(viewModel.pagationDataArray.value)
//        delegate?.callbackDialogListRoom(Rooms:viewModel.pagationDataArray.value.Rooms,date: date)
    }
}

