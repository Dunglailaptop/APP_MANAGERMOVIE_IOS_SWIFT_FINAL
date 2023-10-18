//
//  ManagementBillFoodComboItemTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 17/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementBillFoodComboItemTableViewCell: UITableViewCell {

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
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.total_prices)
            lbl_number.text = String(data!.id)
            lbl_quantity.text = String(data!.quantity)
        }
    }
    
}
