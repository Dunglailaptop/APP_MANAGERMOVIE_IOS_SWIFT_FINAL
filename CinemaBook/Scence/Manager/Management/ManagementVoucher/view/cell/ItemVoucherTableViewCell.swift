//
//  ItemVoucherTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemVoucherTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_percent: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_id_vooucher: UILabel!
    @IBOutlet weak var image_avater: UIImageView!
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
        didSet {
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.price)
            lbl_percent.text = String(data!.percent) + "%"
            lbl_name_voucher.text = data!.namevoucher
            lbl_id_vooucher.text = "Mã voucher: " + String(data!.idvoucher)
            image_avater.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
            
        }
    }
    
}
