//
//  EnterOTPViewController + Extension.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 02/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import JonAlert
import ObjectMapper

extension EnterOTPViewController {
    func verifyCode() {
        viewModel.checkOTP().subscribe(onNext:{[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "Tạo tài khoản thành công vui lòng đăng nhập tài khoản mới để sử dụng các dịch vụ tại rạp")
                viewModel.makeLoginViewController(username: response.data as! String)
            }else{

                OTP_text_field_view.initializeUI()
                OTP_text_field_view.isUserInteractionEnabled = false
                errorCounter -= 1
                var timeToUnEnableOPTEnterView = viewModel.timeToLockOPTEnterView.value
                timeToUnEnableOPTEnterView += 3*(5 - errorCounter)
                viewModel.timeToLockOPTEnterView.accept(timeToUnEnableOPTEnterView)
                JonAlert.show(
                    message: String(format: "Bạn còn %d lần nhập OTP", errorCounter),
                    andIcon: UIImage(named: Constans.WARNING_MESSAGE.ICON_WARNING),
                    duration: 2.0)
                if(errorCounter == 0){
                    viewModel.makeLoginViewController(username: "")
                }
                Toast.show(message: response.message ?? "", controller: self)

            }
        }).disposed(by: rxbag)
    }


    

   
}
