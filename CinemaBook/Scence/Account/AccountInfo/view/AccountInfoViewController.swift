//
//  AccountInfoViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import MWPhotoBrowser

class AccountInfoViewController: BaseViewController {

    var type_dy = ""
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var male: UIImageView!
    
    @IBOutlet weak var female: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    var viewModel = AccountInfoViewModel()
    var router = AccountInfoRouter()
    var userinfo = Users()
    var idUser = 0
    var imagecover = [UIImage]()
     var selectedAssets = [PHAsset]()
    var nameImage: [String] = []
    
    @IBOutlet weak var lbl_btn_title: UILabel!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_username: UITextField!
    
    @IBOutlet weak var txt_idUser: UITextField!
    
   
    @IBOutlet weak var txt_role: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    
    @IBOutlet weak var txt_birthday: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        checkvaliad()
      
        // Do any additional setup after loading the view.
    }
    
    func checkvaliad() {
          _ = txt_username.rx.text.map{String($0!.prefix(50))}.map({ (str) -> Users in
                self.txt_username.text = str
                var clonedata = self.viewModel.dataArray.value
                clonedata.fullname = str
                return clonedata
                 }).bind(to: viewModel.dataArray)
            _ = txt_phone.rx.text.map{String($0!.prefix(10))}.map({(str) -> Users in
                              self.txt_phone.text = str
                              var clonedata = self.viewModel.dataArray.value
                              clonedata.phone = str
                              return clonedata
                          }).bind(to: viewModel.dataArray)
            _ = txt_email.rx.text.map{String($0!.prefix(20))}.map({(str) -> Users in
                              self.txt_email.text = str
                              var clonedata = self.viewModel.dataArray.value
                              clonedata.email = str
                              return clonedata
                          }).bind(to: viewModel.dataArray)
        
           
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       switch type_dy {
                        case "CREATE":
                            var id = viewModel.dataArray.value
                            id.idusers = idUser
                            viewModel.dataArray.accept(id)
                            lbl_title.text = "TẠO NHÂN VIÊN MỚI"
                            lbl_btn_title.text = "TẠO NHÂN VIÊN"
                            return
                        case "UPDATE":
                            var id = viewModel.dataArray.value
                            id.idusers = idUser
                            viewModel.dataArray.accept(id)
                            lbl_title.text = "CẬP NHẬT NHÂN VIÊN"
                            lbl_btn_title.text = "CẬP NHẬT"
                            return
                        case "ACCOUNT":
                            var id = viewModel.dataArray.value
                            id.idusers = ManageCacheObject.getCurrentUserInfo().idusers
                            viewModel.dataArray.accept(id)
                            lbl_title.text = "THÔNG TIN TÀI KHOẢN"
                            lbl_btn_title.text = "CẬP NHẬT"
                                getInfoAccount()
                            return
                        default:
                            return
                        }
           
      
      
    }
    

    @IBAction func btn_chooseavatar(_ sender: Any) {
       openPhotoLibrary()
    }
    
   
    @IBAction func btn_chooseBrithday(_ sender: Any) {
        showDateTimePicker(dateTimeData: userinfo.birthday)
    }
  

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    @IBAction func btn_updateAccount(_ sender: Any) {
        if imagecover.count > 0 {
            self.postUpdateWithAvatar()
        }else {
              self.postUpdateAccount()
        }
      
    }
    
    @IBAction func btn_male(_ sender: Any) {
        male.image = UIImage(named: "icon-radio-checked")
        female.image = UIImage(named: "icon-radio-uncheck")
    }
    
    @IBAction func btn_female(_ sender: Any) {
        male.image = UIImage(named: "icon-radio-uncheck")
              female.image = UIImage(named: "icon-radio-checked")
    }
    
}
