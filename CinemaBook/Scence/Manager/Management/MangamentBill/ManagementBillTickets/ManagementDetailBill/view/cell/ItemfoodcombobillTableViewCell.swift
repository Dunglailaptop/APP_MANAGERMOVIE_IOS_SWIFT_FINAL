//
//  ItemfoodcombobillTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 26/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemfoodcombobillTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_price: UILabel!
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
    var data: DetailFoodComboBill? = nil {
        didSet {
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.totalprice)
            lbl_name_food.text = data?.namefoodcombo
            self.image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.image)), placeholder:  UIImage(named: "image_defauft_medium"))
        }
    }
    
}
