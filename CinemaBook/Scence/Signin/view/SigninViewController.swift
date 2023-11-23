//
//  SigninViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay
import ObjectMapper
import JonAlert

class SigninViewController: BaseViewController {

    @IBOutlet weak var txt_fullname: UITextField!
    
    @IBOutlet weak var txt_username: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    
    @IBOutlet weak var txt_accesspassword: UITextField!
    
    @IBOutlet weak var txt_email: UITextField!
    
    
    @IBOutlet weak var lbl_error_fullname: UILabel!
    
    @IBOutlet weak var lbl_error_username: UILabel!
    
    @IBOutlet weak var lbl_error_password: UILabel!
    
    @IBOutlet weak var lbl_accesspassword: UILabel!
    
    @IBOutlet weak var lbl_error_email: UILabel!
    var viewModel = SigninViewModel()
    var router = SigninRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
       setup()
    }


    @IBAction func btn_makePopToViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_createAccount(_ sender: Any) {
        _ = isEmployeeInforValid.take(1).subscribe(onNext: {[self] (isValid) in
            
            if isValid {
            checkaccount()
            }
        }).disposed(by: rxbag)
    }
    
}
extension SigninViewController {
    func setup() {
        _ = txt_fullname.rx.text.map{ $0 ?? ""}.bind(to: viewModel.fullname).disposed(by: rxbag)
        _ = txt_username.rx.text.map{ $0 ?? ""}.bind(to: viewModel.username).disposed(by: rxbag)
        _ = txt_password.rx.text.map{ $0 ?? ""}.bind(to: viewModel.password).disposed(by: rxbag)
        _ = txt_accesspassword.rx.text.map{$0 ?? ""}.bind(to: viewModel.accesspassword)

        _ = txt_email.rx.text.map{ $0 ?? ""}.bind(to: viewModel.email)
    }
    
    var isEmployeeInforValid: Observable<Bool>{
        return Observable.combineLatest(isFullname,isName,isPassword,isAccesspassword, isEmail){$0 && $1 && $2 && $3 && $4}
    }
    private var isFullname: Observable<Bool>{
        return viewModel.fullname.map{$0 ?? ""}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
            lbl_error_fullname.isHidden = false

            if name.count < 2{
                lbl_error_fullname.text = "Độ dài tối thiểu 2 ký tự"
                return false
            }

            lbl_error_fullname.isHidden = true
            lbl_error_fullname.text = ""
            return true
        }

    }
    private var isName: Observable<Bool>{
        return viewModel.username.map{$0 ?? ""}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
            lbl_error_username.isHidden = false

            if name.count < 2{
                lbl_error_username.text = "Độ dài tối thiểu 2 ký tự"
                return false
            }

            lbl_error_username.isHidden = true
            lbl_error_username.text = ""
            return true
        }

    }
    private var isPassword: Observable<Bool>{
        return viewModel.password.map{$0 ?? ""}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
                lbl_error_password.isHidden = false

            if name.count < 2{
                lbl_error_password.text = "Độ dài tối thiểu 2 ký tự"
                return false
            }

            lbl_error_password.isHidden = true
            lbl_error_password.text = ""
            return true
        }

    }
    private var isAccesspassword: Observable<Bool>{
        return viewModel.accesspassword.map{$0 ?? ""}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
                lbl_accesspassword.isHidden = false

            if name.count < 2{
                lbl_accesspassword.text = "Độ dài tối thiểu 2 ký tự"
                return false
            }

            lbl_accesspassword.isHidden = true
            lbl_accesspassword.text = ""
            return true
        }

    }
    private var isEmail: Observable<Bool>{
        return viewModel.email.map{$0 ?? ""}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
                lbl_error_email.isHidden = false

            if name.count < 2{
                lbl_error_email.text = "Độ dài tối thiểu 2 ký tự"
                return false
            }

            lbl_error_email.isHidden = true
            lbl_error_email.text = ""
            return true
        }

    }
    private func validate(){
        _ = isName.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_username.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        _ = isFullname.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_fullname.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        _ = isPassword.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_password.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        _ = isAccesspassword.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_accesspassword.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        _ = isEmail.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_email.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
       
        
        
    }
    
}
extension SigninViewController {
    func checkaccount() {
        viewModel.checkaccount().subscribe(onNext: {
            [self] (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                sendOTP()
            }else
            {
                JonAlert.showError(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ")
            }
        }).disposed(by: rxbag)
    }
    
    
    func sendOTP(){
        viewModel.getOTP().subscribe(onNext: {[self] (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                viewModel.makeToOTPViewController()
            }else {
                JonAlert.showError(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")

            }
        }).disposed(by: rxbag)
    }
}
