//
//  ManagementRoomCreateViewController+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 9/25/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift
import JonAlert

extension ManagementRoomCreateViewController {
    func CreateRoom() {
        viewModel.CreateRoom().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                JonAlert.showSuccess(message: "Thêm thành công phòng chiếu")
                self.delegate?.callbackCreateRoominfo()
            }else {
                  JonAlert.showSuccess(message: "Thêm không thành công xin vui lòng kiểm tra lại")
             
            }
        })
    }
}
