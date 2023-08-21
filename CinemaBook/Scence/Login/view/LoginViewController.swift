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


class LoginViewController: BaseViewController {

    var viewModel = LoginViewModel()
    var router = LoginRouter()
    
    
    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        txt_password.isSecureTextEntry = true
        txt_username.rx.text.map{ $0 ?? ""}.bind(to: viewModel.username)
          txt_password.rx.text.map{ $0 ?? ""}.bind(to: viewModel.password)
    }


   
    @IBAction func btn_actionLogin(_ sender: Any) {
        self.getConfig()
    }
    
}
