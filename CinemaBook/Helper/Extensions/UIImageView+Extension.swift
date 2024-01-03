////
////  UIImageView+Extension.swift
////  ALOLINE
////
////  Created by Macbook Pro M1 Techres - BE65F182D41C on 11/10/2022.
////  Copyright © 2022 Android developer. All rights reserved.
////
//
//
//
import UIKit
import Kingfisher

extension UIImageView {
    func setBadge(value: String) {
           // Create and position badge view
        let badgeLabel = UILabel(frame: CGRect(x: self.frame.size.width - 30, y: self.frame.size.height - 30, width: 20, height: 20))
           badgeLabel.textAlignment = .center
           badgeLabel.textColor = .white
           badgeLabel.backgroundColor = .red
           badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / 2
           badgeLabel.clipsToBounds = true
           badgeLabel.font = UIFont.systemFont(ofSize: 10)
           badgeLabel.text = value
           
           // Add badge view as a subview
           self.addSubview(badgeLabel)
       }
//    func setKingfisherImageView(image: String?, placeholder: String = "") {
//        var path = ""
//        if let url = image {
//            path = url
//        }
//
//        if placeholder.isEmpty {
//            self.kf.indicatorType = .activity
//            let indicator = self.kf.indicator?.view as? UIActivityIndicatorView
//            //indicator?.style = .whiteLarge
//            indicator?.color = ColorUtils.main_color()
//        }
//
//        self.kf.setImage(
//            with: URL(string: path),
//            placeholder: UIImage(named: placeholder),
//            options: [
//                .transition(.fade(1)),
//                .cacheOriginalImage
//            ])
//    }
}
