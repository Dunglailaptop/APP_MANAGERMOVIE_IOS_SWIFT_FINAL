//
//  ItemProductComboTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 10/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemProductComboTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_desscription: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var image_combo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_name.adjustsFontSizeToFitWidth = true
        lbl_desscription.adjustsFontSizeToFitWidth = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data:FoodCombo? = nil {
        didSet {
            lbl_name.text = data?.nametittle
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.priceCombo)
            lbl_desscription.text = data?.descriptions
             image_combo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder: UIImage(named: "image_defauft_medium"))
        }
    }
    
}
