//
//  ManageDetailBillFoodComboItemTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 16/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManageDetailBillFoodComboItemTableViewCell: UITableViewCell {

    @IBOutlet weak var image_foodcombo: UIImageView!
    
    @IBOutlet weak var txt_tittle: UITextView!
    @IBOutlet weak var lbl_price_foodcombo: UILabel!
    @IBOutlet weak var lbl_name_foodcombo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: FoodCombo? = nil {
        didSet {
            lbl_name_foodcombo.text = data!.nametittle
            lbl_price_foodcombo.text = Utils.stringVietnameseFormatWithNumber(amount: data!.priceCombo)
            image_foodcombo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder:  UIImage(named: "image_defauft_medium"))
            txt_tittle.text = data?.nametittle
        }
    }
    
}
