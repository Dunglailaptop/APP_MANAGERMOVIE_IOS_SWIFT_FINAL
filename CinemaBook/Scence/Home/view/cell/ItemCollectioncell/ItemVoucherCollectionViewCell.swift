//
//  ItemVoucherCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/8/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemVoucherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var image_poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var data: voucher? = nil {
        didSet{
            lbl_title.text = data?.namevoucher
            self.image_poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
        }
    }

}
