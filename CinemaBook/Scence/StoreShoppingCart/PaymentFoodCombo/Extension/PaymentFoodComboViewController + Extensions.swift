//
//  PaymentFoodComboViewController + Extensions.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 15/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import JonAlert

extension PaymentFoodComboViewController {
    func paymentBillFoodCombo() {
        viewModel.PaymentBillFoodCombo().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<PaymentFoodCombo>().map(JSONObject: response.data) {
                    dLog(data)
                    JonAlert.showSuccess(message: String(data.id))
                }
            }
        })
    }
}
