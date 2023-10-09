//
//  LoginViewController.swift
//  CinemaBook
//
//  Created by dungtien on 7/31/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JonAlert

class LoginViewController: BaseViewController {

    var viewModel = LoginViewModel()
    var router = LoginRouter()
    
    
    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        
       checkvalid()
    }


    func checkvalid() {
        txt_password.isSecureTextEntry = true
        _ = txt_username.rx.text.map{(str) in
            if str!.count > 50 {
                JonAlert.showError(message: "Độ dài tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Account in
            self.txt_username.text = str
            var cloneEmployeeInfor = self.viewModel.account.value
            cloneEmployeeInfor.username = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.account).disposed(by: rxbag)
        
        _ = txt_password.rx.text.map{(str) in
            if str!.count > 50 {
                JonAlert.showError(message: "Độ dài tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Account in
            self.txt_password.text = str
            var cloneEmployeeInfor = self.viewModel.account.value
            cloneEmployeeInfor.password = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.account).disposed(by: rxbag)
    }
   
    @IBAction func btn_actionLogin(_ sender: Any) {
        self.getConfig()
    }
    
}
