//
//  EnterOTPViewController.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 02/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import OTPFieldView
import RxSwift


class EnterOTPViewController: BaseViewController {
    var viewModel = EnterOTPViewModel()
    var router = EnterOTPRouter()
    @IBOutlet weak var OTP_text_field_view: OTPFieldView!
    var iduser = 0
    var typecheck = 0
    var username = ""
    var emails = ""
    var fullname = ""
    var password = ""
        
    var restaurant_brand_name = ""
    weak var reEnterTimer: Timer?
    weak var errorTimer: Timer?
    var OTPCountDown = 0
    var errorCounter = 5
    var timeToUnEnableOPTEnterView = 0
   
  
    @IBOutlet weak var btn_send_OTP_again: UIButton!
    @IBOutlet weak var view_OTP_count_down: UIView!
    @IBOutlet weak var lbl_count_down_value: UILabel!
    
    @IBOutlet weak var lbl_time_to_lock_OPT_View: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        setUpOtpView()
        viewModel.emails.accept(emails)
        var dataaccountnew = viewModel.dataAccount.value
        dataaccountnew.fullname = fullname
        dataaccountnew.emails = emails
        dataaccountnew.password = password
        dataaccountnew.username = username
        dataaccountnew.iduser = iduser
        viewModel.dataAccount.accept(dataaccountnew)
        setOTPCountDown()
        

        viewModel.timeToLockOPTEnterView.subscribe(onNext: {[self] (value) in
            
            if(value == 0){
                lbl_time_to_lock_OPT_View.isHidden = true
                OTP_text_field_view.isUserInteractionEnabled = true
                errorTimer?.invalidate()
            }else {
                errorTimer?.invalidate()
                var time_to_unlock_OTP_view = value + 1
                errorTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
                    time_to_unlock_OTP_view -= 1
                    lbl_time_to_lock_OPT_View.text = String(format: "%d s", time_to_unlock_OTP_view)
                    if(time_to_unlock_OTP_view == 0){
                        OTP_text_field_view.isUserInteractionEnabled = true
                        lbl_time_to_lock_OPT_View.isHidden = true
                        viewModel.timeToLockOPTEnterView.accept(time_to_unlock_OTP_view)
                        errorTimer?.invalidate()
                    
                    }else{
                        lbl_time_to_lock_OPT_View.isHidden = false
                        OTP_text_field_view.isUserInteractionEnabled = false
                    }
                  
                
                }
            }
            
           
        })

    }
    deinit {
        reEnterTimer?.invalidate()
        errorTimer?.invalidate()
    }

    
    private func setUpOtpView(){
        self.OTP_text_field_view.fieldsCount = 4
        self.OTP_text_field_view.fieldBorderWidth = 2
        self.OTP_text_field_view.defaultBorderColor = ColorUtils.gray_200()
        self.OTP_text_field_view.defaultBackgroundColor = ColorUtils.gray_000()
        self.OTP_text_field_view.filledBorderColor = ColorUtils.gray_200()
        self.OTP_text_field_view.filledBackgroundColor = ColorUtils.gray_000()
        self.OTP_text_field_view.cursorColor = ColorUtils.gray_400()
        self.OTP_text_field_view.displayType = .roundedCorner
        
        self.OTP_text_field_view.fieldSize = 40
        self.OTP_text_field_view.separatorSpace = 8
        self.OTP_text_field_view.shouldAllowIntermediateEditing = false
        self.OTP_text_field_view.delegate = self
        self.OTP_text_field_view.initializeUI()
        
    }
    
    func setOTPCountDown(){
        self.OTPCountDown = 60
        btn_send_OTP_again.isHidden = true
        view_OTP_count_down.isHidden = false
        reEnterTimer?.invalidate()
        reEnterTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self!.OTPCountDown -= 1
            self!.lbl_count_down_value.text = String(format: "%ds", self!.OTPCountDown)
            if(self!.OTPCountDown == 0){
                self!.reEnterTimer!.invalidate()
                self!.btn_send_OTP_again.isHidden = false
                self!.view_OTP_count_down.isHidden = true
            }
        }
    }
    
    @IBAction func actionToNavigateBackToLogin(_ sender: Any) {
        viewModel.makeLoginViewController(username: "")
    }
    
    
    @IBAction func actionClickToGetOTP(_ sender: Any) {
//        getSession()
    }
    
}


extension EnterOTPViewController: OTPFieldViewDelegate{
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
     
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        viewModel.OTPCode.accept(otpString)
        if typecheck == 1{
            verifyCodeforgotpassword()
        } else {
            verifyCode()
        }
        
    }
    
}
