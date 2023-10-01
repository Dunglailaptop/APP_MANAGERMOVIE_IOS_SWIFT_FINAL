//
//  BookingProductComboViewController+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 10/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ObjectMapper

extension BookingProductComboViewController {
    func getListCombo() {
        viewModel.getListFoodCombo().subscribe(onNext: {
        (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<FoodCombo>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                }
            }
        })
    }
}
