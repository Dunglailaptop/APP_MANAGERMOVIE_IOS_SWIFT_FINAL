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

extension DetailMovieViewController {
    func getDetailMovie() {
        viewModel.getDetailMovie().subscribe(onNext: {
           (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue) {
                if let data = Mapper<Movie>().map(JSONObject: response.data)
                {
                    self.viewModel.data.accept(data)
                    self.lbl_namemovie.text = data.namemovie
                    self.lbl_author.text = data.author
                    self.lbl_text.text = data.describes
                    self.setupvideo(url: data.videofile)
                    self.poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
                }
            }
        })
    }
}
