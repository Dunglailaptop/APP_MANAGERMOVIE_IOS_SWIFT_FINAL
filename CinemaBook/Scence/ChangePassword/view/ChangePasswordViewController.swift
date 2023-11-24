//
//  ChangePasswordViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 23/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import ObjectMapper
import JonAlert

class ChangePasswordViewController: BaseViewController {
    
    var viewModel = ChangePasswordViewModel()
    var router = ChangePasswordRouter()
    var accdata = Account()
    var typecheck = 0
    @IBOutlet weak var txt_username: UITextField!
    
    @IBOutlet weak var btn_update: UIButton!
    @IBOutlet weak var txt_password_new: UITextField!
    
    @IBOutlet weak var btn_backtologin: UIButton!
    @IBOutlet weak var view_popto: UIView!
    @IBOutlet weak var txt_password_access: UITextField!
    @IBOutlet weak var lbl_access_password: UILabel!
    @IBOutlet weak var lbl_new_password: UILabel!
    @IBOutlet weak var lbl_error_name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        enableBtnUpdatePassword(condition: false)
        viewModel.dataaccount.accept(accdata)
        checkvalid()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if typecheck == 1 {
            view_popto.isHidden = true
            btn_backtologin.isHidden = false
        }else {
            view_popto.isHidden = false
            btn_backtologin.isHidden = true
        }
    }

    @IBAction func btn_backtologinviewcontroller(_ sender: Any) {
        viewModel.makeToLoginViewController()
    }
    
    @IBAction func btn_changePassword(_ sender: Any) {
        _ = isEmployeeInforValid.take(1).subscribe(onNext: {[self] (isValid) in
            if isValid {
               changepassword()
            }
            
            
        }).disposed(by: rxbag)
    }
    
   
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    

}
extension ChangePasswordViewController: UITextFieldDelegate {
    func checkvalid() {
      
        txt_username.text = viewModel.dataaccount.value.username
        
        _ = txt_password_new.rx.text.map{(str) in
            if str!.count > 50 {
                self.lbl_new_password.text = "Đô dài tối đa 10 ký tự"
            }
            return String(str!.prefix(20))
        }.map({(str) -> Account in
            self.txt_password_new.text = str
            var cloneEmployeeInfor = self.viewModel.dataaccount.value
            cloneEmployeeInfor.password = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.dataaccount).disposed(by: rxbag)
        _ = txt_password_access.rx.text.map{(str) in
            if str!.count > 50 {
                self.lbl_access_password.text = "Đô dài tối đa 10 ký tự"
            }
            return String(str!.prefix(20))
        }.map({(str) -> Account in
            self.txt_password_access.text = str
            var cloneEmployeeInfor = self.viewModel.dataaccount.value
            cloneEmployeeInfor.repasswrod = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.dataaccount).disposed(by: rxbag)
        
        
        lbl_new_password.isHidden = true
        lbl_new_password.isHidden = true
       
        
        txt_password_new.delegate = self
        txt_password_new.addTarget(self, action:#selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        txt_password_access.delegate = self
        txt_password_access.addTarget(self, action:#selector(textFieldDidEndEditingReEnterNewPassword(_:)), for: .editingChanged)
    }
    var isEmployeeInforValid: Observable<Bool>{
        return Observable.combineLatest(isPassword,isRePassword){$0 && $1}
    }
  
    private var isPassword: Observable<Bool>{
        return viewModel.dataaccount.map{$0.password}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
                lbl_new_password.isHidden = false

            if name.count < 2{
                lbl_new_password.text = "Vui lòng nhập mật khẩu"
                return false
            }

            lbl_new_password.isHidden = true
            lbl_new_password.text = ""
            return true
        }

    }
    private var isRePassword: Observable<Bool>{
        return viewModel.dataaccount.map{$0.repasswrod}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
                lbl_access_password.isHidden = false

            if name.count < 2{
                lbl_access_password.text = "Vui lòng nhập mật khẩu xác nhận"
                return false
            }

            lbl_access_password.isHidden = true
            lbl_access_password.text = ""
            return true
        }

    }
    private func validate(){
        _ = isPassword.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_new_password.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
    
        _ = isRePassword.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_access_password.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
       
       
        
        
    }
    private func enableBtnUpdatePassword(condition:Bool){
 
        if condition == true{
            btn_update.backgroundColor = UIColor(hex: "C7D9EC")
            btn_update.setTitleColor(UIColor(hex: "1462B0"), for: .normal)
            btn_update.isEnabled = true
        }else{
            btn_update.backgroundColor = UIColor(hex: "C5C6C9")
            btn_update.setTitleColor(UIColor(hex: "FFFFFF"), for: .normal)
            btn_update.isEnabled = false
        }
        
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField){
        var ReEnterNewPassword = viewModel.dataaccount.value.repasswrod
        enableBtnUpdatePassword(
            condition:!ReEnterNewPassword.isEmpty && textField.text == ReEnterNewPassword
            ? true : false)
        
    
    }
    
    @objc func textFieldDidEndEditingReEnterNewPassword(_ textField: UITextField) {
        var newPassword = viewModel.dataaccount.value.password
        

        enableBtnUpdatePassword(
            condition:!newPassword.isEmpty && textField.text == newPassword
            ? true : false)
    }
    
}
extension ChangePasswordViewController {
    func changepassword() {
        viewModel.changePassword().subscribe(onNext: {
            [self](response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                JonAlert.showSuccess(message: response.message ?? "Có lỗi xảy ra trong qúa trình kết nối")
                viewModel.makeToLoginViewController()
            }else {
                JonAlert.showError(message: response.message ?? "Có lỗi xảy ra trong qúa trình kết nối")
            }
        })
    }
}
