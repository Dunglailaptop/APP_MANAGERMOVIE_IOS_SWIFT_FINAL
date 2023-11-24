//
//  ForgotPasswordViewController.swift
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

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var lbl_error_info: UILabel!
    @IBOutlet weak var txt_username: UITextField!
    var viewModel = ForgotPasswordViewModel()
    var router = ForgotRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
       checkvalid()
        
    }


    @IBAction func btn_makePopToViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func checkvalid(){
        _ = txt_username.rx.text.map{(str) in
            if str!.count > 50 {
                JonAlert.showError(message: "Độ dài tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Account in
            self.txt_username.text = str
            var cloneEmployeeInfor = self.viewModel.dataAccount.value
            cloneEmployeeInfor.username = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.dataAccount).disposed(by: rxbag)
    }
  
    @IBAction func btn_access_forgotpassword(_ sender: Any) {
        _ = isUsername.take(1).subscribe(onNext: {[self](isvalid) in
            if isvalid {
                forgotpassword()
            }
        }).disposed(by: rxbag)
    }
   
    private var isUsername: Observable<Bool>{
        return viewModel.dataAccount.map{$0.username}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
            lbl_error_info.isHidden = false

            if name.count < 2{
                lbl_error_info.text = "Vui lòng nhập tên tài khoản"
                return false
            }

            lbl_error_info.isHidden = true
            lbl_error_info.text = ""
            return true
        }

    }
}
extension ForgotPasswordViewController {
    func sendOTP(){
        viewModel.getOTP().subscribe(onNext: {[self] (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
               
                    viewModel.makeToOTPenter()
             
               
            }else {
                JonAlert.showError(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")

            }
        }).disposed(by: rxbag)
    }
    
    func forgotpassword() {
        viewModel.searchaccountforgotpassword().subscribe(onNext: {
            [self] (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue) {
                if let data = Mapper<Account>().map(JSONObject: response.data){
                    viewModel.dataAccount.accept(data)
                    sendOTP()
                }
            }else
            {
                JonAlert.showError(message: response.message ?? "Có lỗi xảy ra trong quá trình xử lý")
            }
        }).disposed(by: rxbag)
    }
}
