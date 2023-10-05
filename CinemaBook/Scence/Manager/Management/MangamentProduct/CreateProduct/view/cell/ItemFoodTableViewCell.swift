//
//  ItemFoodTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/29/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemFoodTableViewCell: UITableViewCell {

    @IBOutlet weak var image_food: UIImageView!
    @IBOutlet weak var lbl_namefood: UILabel!
    @IBOutlet weak var image_icon_check: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var data:Food? = nil {
        didSet {
            lbl_namefood.text = data?.namefood
            image_icon_check.isHidden = data?.isSelected == ACTIVE ? false:true
        }
    }
    
}
