//
//  ManagementMovieViewController+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 9/15/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import JonAlert
import ObjectMapper


extension ManagementMovieViewController {
    func getListMovie() {
        viewModel.getListMovie().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Movie>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                }
                
            }else {
                JonAlert.showError(message: "Có lỗi trong quá trình kết nối")
            }
            
            }).disposed(by: rxbag)
    }
}
