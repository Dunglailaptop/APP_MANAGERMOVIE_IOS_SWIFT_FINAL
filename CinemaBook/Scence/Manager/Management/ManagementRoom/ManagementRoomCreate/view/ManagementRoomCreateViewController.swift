//
//  ManagementRoomCreateViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/25/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementRoomCreateViewController: UIViewController {

    var viewModel = ManagementRoomCreateViewModel()
    var router = MangementRoomCreateRouter()
    
    @IBOutlet weak var txt_numberOfrow: UITextField!
    @IBOutlet weak var txt_numberChairALL: UITextField!
    @IBOutlet weak var txt_name_room: UITextField!
    @IBOutlet weak var txt_idcinema: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view:self,router:router)
        checkValid()
        // Do any additional setup after loading the view.
    }

    @IBAction func btn_makePopViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    func checkValid() {
        txt_idcinema.text = ManageCacheObject.getCurrentCinema().idcinema as? String
        var dataclone = viewModel.data.value
        dataclone.idcinema = ManageCacheObject.getCurrentCinema().idcinema
        dataclone.allchair = 200
        dataclone.chairinrow = 13
        viewModel.data.accept(dataclone)
           _ = txt_name_room.rx.text.map({(str) -> Room in
                var cloneRoom = self.viewModel.data.value
            cloneRoom.nameroom = str as! String
                return cloneRoom
           }).bind(to: viewModel.data)
//        _ = txt_numberChairALL.rx.text.map({(str) -> Room in
//                      var cloneRoom = self.viewModel.data.value
//            cloneRoom.allchair = (str as Int
//                      return cloneRoom
//                 }).bind(to: viewModel.data)
//        _ = txt_numberOfrow.rx.text.map({(str) -> Room in
//                      var cloneRoom = self.viewModel.data.value
//            cloneRoom.chairinrow = str as! Int
//                      return cloneRoom
//                 }).bind(to: viewModel.data)

    }

    @IBAction func btn_CreateRoom(_ sender: Any) {
        self.CreateRoom()
    }
}
