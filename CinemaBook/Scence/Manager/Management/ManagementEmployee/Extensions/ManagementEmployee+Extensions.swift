//
//  ManagementEmployee+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 9/11/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

extension ManagementEmployeeViewController {
    func getlistEmployee() {
        viewModel.getListEmployee().subscribe(onNext: { (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Users>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                }
            }
            
            }).disposed(by: rxbag)
    }
}
