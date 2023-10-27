//
//  ManagementBillFoodComboItemTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 17/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementBillFoodComboItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_time_order: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var view_status: UIView!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_quantity: UILabel!
    @IBOutlet weak var lbl_number: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: PaymentInfoBillFoodCombo? = nil {
        didSet {
            if data?.status == 0 {
                view_status.backgroundColor = .red
                lbl_status.text = "CHỜ NHẬN"
            }else {
                view_status.backgroundColor = .green
                lbl_status.text = "ĐÃ THANH TOÁN"
            }
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.total_prices)
            lbl_number.text = String(data!.id)
            lbl_quantity.text = String(data!.quantity)
            var timeorder = data?.time.components(separatedBy: "T")
            lbl_time_order.text = timeorder![0] + " " + timeorder![1]
        }
    }
    
}
