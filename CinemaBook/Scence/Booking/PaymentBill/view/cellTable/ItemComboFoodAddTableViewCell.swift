//
//  ItemComboFoodAddTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 10/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemComboFoodAddTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_number_combo: UILabel!
    @IBOutlet weak var ilbl_name_combo: UILabel!
    @IBOutlet weak var image_combo: UIImageView!
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
            lbl_number_combo.text = String(data!.quantity)
            ilbl_name_combo.text = data?.nametittle
             image_combo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder: UIImage(named: "image_defauft_medium"))
        }
    }
}
