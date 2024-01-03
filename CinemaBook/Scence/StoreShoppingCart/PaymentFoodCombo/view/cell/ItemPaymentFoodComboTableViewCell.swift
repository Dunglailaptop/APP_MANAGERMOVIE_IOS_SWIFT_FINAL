//
//  ItemPaymentFoodComboTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 14/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemPaymentFoodComboTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_number_combo: UILabel!
    @IBOutlet weak var image_food: UIImageView!
    
    @IBOutlet weak var lbl_name_food: UILabel!
    
    @IBOutlet weak var lbl_total_money: UILabel!
    
    @IBOutlet weak var txt_text_list: UITextView!
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
            dLog(data)
            lbl_name_food.text = String(data!.nametittle)
            lbl_number_combo.text = "x" + String(data!.quantityRealtime)
            lbl_total_money.text = Utils.stringVietnameseFormatWithNumber(amount: data!.quantityRealtime * data!.priceCombo)
            image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder:  UIImage(named: "image_defauft_medium"))
            var textlistfood = ""
            var textsl = 0

            data?.foods.enumerated().forEach { (index,value) in
                dLog(value.quantityRealTime)
                textsl = value.quantityRealTime
                textlistfood += "+\(textsl)x\(value.namefood)\n"
            }

            txt_text_list.text = textlistfood
        }
    }
}
