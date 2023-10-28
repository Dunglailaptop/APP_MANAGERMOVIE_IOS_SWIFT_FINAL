//
//  ItemFoodInManagementTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemFoodInManagementTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_price_food: UILabel!
    @IBOutlet weak var lbl_name_food: UILabel!
    @IBOutlet weak var image_food: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var data: Food? = nil {
        didSet {
            dLog(data)
            lbl_name_food.text = data?.namefood
            lbl_price_food.text = Utils.stringVietnameseFormatWithNumber(amount: data!.pricefood)
             image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder: UIImage(named: "image_defauft_medium"))
        }
    }
}
