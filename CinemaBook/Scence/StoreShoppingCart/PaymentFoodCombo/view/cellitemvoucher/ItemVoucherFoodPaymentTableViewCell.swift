//
//  ItemVoucherFoodPaymentTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 25/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemVoucherFoodPaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var icon_check: UIImageView!
    @IBOutlet weak var poster_voucher: UIImageView!
    @IBOutlet weak var lbl_reduce_voucher: UILabel!
    @IBOutlet weak var lbl_name_voucher: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: voucher? = nil {
        didSet{
            lbl_name_voucher.text = data?.namevoucher
          var total_category =  data!.price > 0 ? String(data!.price): String(data!.percent) + "%"
            poster_voucher.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
            lbl_reduce_voucher.text = "Loại giảm giá: " + total_category
            if data!.isCheck == ACTIVE {
                icon_check.image = UIImage(named: "check")
            }else {
                icon_check.image = UIImage(named: "icon-check-disable")
            }
        }
    }
    
    
}
