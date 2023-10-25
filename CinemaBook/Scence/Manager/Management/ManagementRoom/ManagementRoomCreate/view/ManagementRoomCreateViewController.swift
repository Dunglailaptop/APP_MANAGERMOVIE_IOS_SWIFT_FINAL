//
//  ManagementRoomCreateViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/25/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay
import ObjectMapper
import JonAlert

class ManagementRoomCreateViewController: BaseViewController {

    var viewModel = ManagementRoomCreateViewModel()
    var router = MangementRoomCreateRouter()
    
//    @IBOutlet weak var txt_numberOfrow: UITextField!
    @IBOutlet weak var txt_numberChairALL: UITextField!
    @IBOutlet weak var txt_name_room: UITextField!
//    @IBOutlet weak var txt_idcinema: UITextField!
    var delegate: DialogCreateRoomInfo?
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
//        txt_idcinema.text = ManageCacheObject.getCurrentCinema().idcinema as? String
        var dataclone = viewModel.data.value
        dataclone.idcinema = ManageCacheObject.getCurrentCinema().idcinema
      
        dataclone.chairinrow = 13
        viewModel.data.accept(dataclone)
           _ = txt_name_room.rx.text.map({(str) -> Room in
                var cloneRoom = self.viewModel.data.value
            cloneRoom.nameroom = str as! String
                return cloneRoom
           }).bind(to: viewModel.data)
//        _ = txt_numberChairALL.rx.text.map{(str) in
//            if str!.count > 50 {
//                JonAlert.showError(message: "Độ dài tối đa 50 ký tự")
//            }
//            return String(str!.prefix(50))
//        }.map({(str) -> Room in
//            self.txt_numberChairALL.text = str
//            var cloneEmployeeInfor = self.viewModel.data.value
//            cloneEmployeeInfor.allchair = Int(str!)
//            return cloneEmployeeInfor
//        }).bind(to: viewModel.data)
        
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
    
    @IBAction func btn_show_quantituinput(_ sender: Any) {
        presentModalInputQuantityViewController(number: 0)
    }
    
    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
extension ManagementRoomCreateViewController: InputQuantityDelegate {
    func presentModalInputQuantityViewController(number: Float) {
            let dialogInputQuantityViewController = DialogInputQuantityViewController()
            dialogInputQuantityViewController.maxQuantity = 100
        dialogInputQuantityViewController.delegate = self
            dialogInputQuantityViewController.current_quantity = number
          
            dialogInputQuantityViewController.view.backgroundColor = ColorUtils.blackTransparent()
            let nav = UINavigationController(rootViewController: dialogInputQuantityViewController)
            // 1
            nav.modalPresentationStyle = .overCurrentContext

            // 2
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    // 3
                    sheet.detents = [.large()]
                }
            } else {
                // Fallback on earlier versions
            }
            // 4
            present(nav, animated: true, completion: nil)
        }
    
    func callbackInputQuantity(number: Float, position: Int) {
        txt_numberChairALL.text = String(Int(number))
        var data = viewModel.data.value
        data.allchair = Int(number)
        viewModel.data.accept(data)
      
    }
}
