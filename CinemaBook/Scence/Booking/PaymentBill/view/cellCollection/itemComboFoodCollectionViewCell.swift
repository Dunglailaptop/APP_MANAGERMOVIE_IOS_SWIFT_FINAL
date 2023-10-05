//
//  itemComboFoodCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 10/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class itemComboFoodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var image_combo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_name.adjustsFontSizeToFitWidth = true
        // Initialization code
    }

    var data: FoodCombo? = nil {
        didSet {
            lbl_name.text = data?.nametittle
             image_combo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder: UIImage(named: "image_defauft_medium"))
        }
    }
}
