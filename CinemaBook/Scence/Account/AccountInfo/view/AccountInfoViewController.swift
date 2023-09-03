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

    @IBOutlet weak var avatar: UIImageView!
    var viewModel = AccountInfoViewModel()
    var router = AccountInfoRouter()
    var userinfo = Users()
    var imagecover = [UIImage]()
     var selectedAssets = [PHAsset]()
    var nameImage: [String] = []
    
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_username: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    
    @IBOutlet weak var txt_birthday: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        checkvaliad()
        // Do any additional setup after loading the view.
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
}
