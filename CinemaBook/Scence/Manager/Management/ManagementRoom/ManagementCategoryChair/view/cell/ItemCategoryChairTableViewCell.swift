//
//  ItemCategoryChairTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemCategoryChairTableViewCell: UITableViewCell {

    @IBOutlet weak var view_color_chair: UIView!
    @IBOutlet weak var lbl_price_chair: UILabel!
    @IBOutlet weak var lbl_name_chair: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: CategoryChair? = nil {
        didSet {
            if data?.colorchair == "1" {
                view_color_chair.backgroundColor = .systemGray
            }
            lbl_price_chair.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data!.price)
            lbl_name_chair.text = data?.namecategorychair
            
        }
    }
}
