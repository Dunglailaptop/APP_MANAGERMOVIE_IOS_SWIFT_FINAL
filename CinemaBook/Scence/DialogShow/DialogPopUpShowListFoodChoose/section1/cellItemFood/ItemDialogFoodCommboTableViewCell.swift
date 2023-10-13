//
//  ItemDialogFoodCommboTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 12/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemDialogFoodCommboTableViewCell: UITableViewCell {

   
    @IBOutlet weak var icon_check: UIImageView!
    @IBOutlet weak var lbl_name_food: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
