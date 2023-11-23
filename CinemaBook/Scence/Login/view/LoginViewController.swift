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
    var check = 0
    @IBOutlet weak var icon_eye: UIImageView!
    var username = "" // if you are create account and System show username in textbox your UI Loigin
    @IBOutlet weak var lbl_error_password: UILabel!
    @IBOutlet weak var lbl_error_username: UILabel!
    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        
       checkvalid()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if username != "" {
            txt_username.text = username
        }
    }

    @IBAction func btn_close_eye(_ sender: Any) {
        check = check == 0 ? 1:0
        icon_eye.image = check == 0 ? UIImage(named: "icon_eye_pass"):UIImage(named: "eye_pass")
        txt_password.isSecureTextEntry =  check == 0 ? true:false
        
    }
    
    func checkvalid() {
        txt_password.isSecureTextEntry = true
        _ = txt_username.rx.text.map{(str) in
            if str!.count > 50 {
                self.lbl_error_password.text = "Độ dài tối đa 50 ký tự"
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
                self.lbl_error_username.text = "Đô dài tối đa 50 ký tự"
            }
            return String(str!.prefix(20))
        }.map({(str) -> Account in
            self.txt_password.text = str
            var cloneEmployeeInfor = self.viewModel.account.value
            cloneEmployeeInfor.password = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.account).disposed(by: rxbag)
    }
   
    @IBAction func btn_actionLogin(_ sender: Any) {
        _ = isEmployeeInforValid.take(1).subscribe(onNext: {[self] (isValid) in
            
            if isValid {
                getConfig()
            }
        }).disposed(by: rxbag)
    }
    @IBAction func btn_Signin(_ sender: Any) {
        let viewc = SigninViewController()
        self.navigationController?.pushViewController(viewc, animated: true)
    }
    
}
extension LoginViewController {
    var isEmployeeInforValid: Observable<Bool>{
        return Observable.combineLatest(isUsername,isPassword){$0 && $1}
    }
    private var isUsername: Observable<Bool>{
        return viewModel.account.map{$0.username}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
                lbl_error_username.isHidden = false

            if name.count < 2{
                lbl_error_username.text = "Độ dài tối thiểu 10 ký tự"
                return false
            }

            lbl_error_username.isHidden = true
            lbl_error_username.text = ""
            return true
        }

    }
    private var isPassword: Observable<Bool>{
        return viewModel.account.map{$0.password}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
                lbl_error_password.isHidden = false

            if name.count < 2{
                lbl_error_password.text = "Độ dài tối thiểu 4 ký tự"
                return false
            }

            lbl_error_password.isHidden = true
            lbl_error_password.text = ""
            return true
        }

    }
    private func validate(){
        _ = isUsername.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_username.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
    
        _ = isPassword.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_password.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
       
       
        
        
    }
}
