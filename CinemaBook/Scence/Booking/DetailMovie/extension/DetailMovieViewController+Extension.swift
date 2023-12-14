//
//  DetailMovieViewController+Extension.swift
//  CinemaBook
//
//  Created by dungtien on 8/21/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ObjectMapper
import Kingfisher
import JonAlert

extension DetailMovieInfoViewController {
    func getDetailMovie() {
        viewModel.getDetailMovie().subscribe(onNext: {
           (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue) {
                if let data = Mapper<Movie>().map(JSONObject: response.data)
                {
                    dLog(data)
                    self.viewModel.dataArray.accept(data)
                    self.setupdata(datas: data)
                }
            }
            }).disposed(by: rxbag)
    }
    
    func setupdata(datas: Movie) {
        self.lbl_nation.text = datas.namenation
        self.lbl_author.text = datas.author
        self.lbl_categorymovie.text = datas.namecategorymovie
        self.lbl_name_movie.text = datas.namemovie
        self.txt_description.text = datas.describes
        self.lbl_timeall.text = String(datas.timeall) + " Phút"
        var date_show = datas.yearbirthday.components(separatedBy: "T")
        self.lbl_date_show.text = date_show[0]
        self.image_poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: datas.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
        view_new_coming.isHidden = datas.statusshow == 0 ? false:true
    }
    
    func getListVoucher() {
        viewModel.getListVoucher().subscribe(onNext: {
            (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue)
            {
                if let data = Mapper<voucher>().mapArray(JSONObject: response.data)
                {
                    self.viewModel.dataArrayVoucher.accept(data)
                }
            }else {
                JonAlert.show(message: "co loi trong qua trinh ket noi")
            }
        })
    }
}
extension DetailMovieInfoViewController {
    func reaload() {
        viewModel.dataArrayVoucher.subscribe(onNext: {
            [weak self] data in
            self!.bannerVoucher.reloadData()
        }).disposed(by: rxbag)
    }
 
}

