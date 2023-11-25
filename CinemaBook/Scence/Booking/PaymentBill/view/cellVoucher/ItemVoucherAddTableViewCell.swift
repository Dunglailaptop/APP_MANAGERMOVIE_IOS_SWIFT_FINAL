//
//  ItemVoucherAddTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 24/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemVoucherAddTableViewCell: UITableViewCell {

    
    @IBOutlet weak var image_voucher: UIImageView!
    @IBOutlet weak var icon_choose: UIImageView!
    @IBOutlet weak var lbl_categoryvoucher: UILabel!
    @IBOutlet weak var LBL_name_voucher: UILabel!
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
            LBL_name_voucher.text = data?.namevoucher
            image_voucher.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder: UIImage(named: "image_defauft_medium"))
            if data?.percent != 0 {
                lbl_categoryvoucher.text = "Loại giảm giá: " + String(data!.percent) + "%"
            }else
            {
                lbl_categoryvoucher.text = "Loại giảm giá: " + Utils.stringVietnameseFormatWithNumber(amount: data!.price) 
            }
            if data!.isCheck == ACTIVE {
                icon_choose.image = UIImage(named: "check")
            }else {
                icon_choose.image = UIImage(named: "icon-check-disable")
            }
        }
    }
    
    
    
}
