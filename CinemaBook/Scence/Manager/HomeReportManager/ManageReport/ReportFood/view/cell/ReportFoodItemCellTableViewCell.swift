//
//  ReportFoodItemCellTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 03/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ReportFoodItemCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var image_food: UIImageView!
    
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_number: UILabel!
    @IBOutlet weak var lbl_name_food: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    var data: ReportFood? = nil {
        didSet
        {
            lbl_name_food.text = data?.namefood
           lbl_number.text = String(data!.stt)
            image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.image)), placeholder:  UIImage(named: "image_defauft_medium"))
            var date = data?.datetimes.components(separatedBy: " ")
            lbl_time.text = date![0]
        }
    }
    
}
