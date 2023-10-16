//
//  ManageBillFoodAccountItemTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 16/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManageBillFoodAccountItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_id_billfoodcombo: UILabel!
    
    @IBOutlet weak var lbl_quantity_foodcombo: UILabel!
    
    @IBOutlet weak var lbl_price_billfoodcombo: UILabel!
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
            lbl_id_billfoodcombo.text = String(data!.id)
            lbl_quantity_foodcombo.text = String(data!.quantity)
            lbl_price_billfoodcombo.text = Utils.stringVietnameseFormatWithNumber(amount: data!.total_prices)
//            lbl_id_billfoodcombo.text = data?.id
        }
    }
    
}
