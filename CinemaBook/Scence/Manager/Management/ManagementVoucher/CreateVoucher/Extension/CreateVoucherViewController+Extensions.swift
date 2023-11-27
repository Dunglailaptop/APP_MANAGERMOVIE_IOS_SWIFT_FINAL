//
//  CreateVoucherViewController+Extensions.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import JonAlert

extension CreateVoucherViewController {
    func postUpdateWithAvatar(){
        var medias = [Medias]()
        var medias_request = Medias()
        var dataImage = viewModel.dataVoucher.value
        medias_request.image = imagecover[0]
        dLog(nameImage)
        
        medias_request.name = nameImage[0]
        medias_request.type = 1
        medias.append(medias_request)
        viewModel.media_request.accept(medias)
        viewModel.uploadImage()
        let connectImage = nameImage[0] + "/" + nameImage[0];
        dataImage.poster = connectImage
        viewModel.dataVoucher.accept(dataImage)
     
      
        if  type_check == "CREATE" {
            createNewVoucher()
        } else  {
            updatevoucher()
        }
    
    }
    
    
    func getDetailVoucher() {
        viewModel.getDetail().subscribe(onNext:  {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<voucher>().map(JSONObject: response.data) {
                    self.viewModel.dataVoucher.accept(data)
                    self.setupDATA()
                }
            }
        })
    }
    
    func updatevoucher() {
        viewModel.updatevoucher().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<voucher>().map(JSONObject: response.data) {
                    self.viewModel.dataVoucher.accept(data)
                }
            }
        })
    }
    
    func setupDATA() {
        self.txt_name.text = viewModel.dataVoucher.value.namevoucher
        self.txt_view_note.text = viewModel.dataVoucher.value.note
        if viewModel.dataVoucher.value.price != 0 {
            icon_price.image = UIImage(named: "check")
            icon_percent.image = UIImage(named: "icon-check-disable")
            view_percent.isHidden = true
            txt_price.text = Utils.stringVietnameseFormatWithNumber(amount: viewModel.dataVoucher.value.price)
            
        }else {
            icon_percent.image = UIImage(named: "check")
            icon_price.image = UIImage(named: "icon-check-disable")
            view_percent.isHidden = false
            txt_percent.text = String(viewModel.dataVoucher.value.percent) + "%"
        }
        avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: viewModel.dataVoucher.value.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
    }
    
    func createNewVoucher() {
        viewModel.createVoucher().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<voucher>().map(JSONObject: response.data){
                    JonAlert.showSuccess(message: "Tạo voucher thành công")
                    self.viewModel.makePopToViewController()
                }else {
                    JonAlert.showError(message: "Tạo voucher thất bại")
                }
            }
        })
    }
}

