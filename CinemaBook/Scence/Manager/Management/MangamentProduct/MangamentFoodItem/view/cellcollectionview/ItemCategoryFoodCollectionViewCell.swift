//
//  ItemCategoryFoodCollectionViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 06/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemCategoryFoodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_namefood: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var data: CategoryFood? = nil {
        didSet {
            lbl_namefood.text = data?.namecategoryfood
            lbl_namefood.backgroundColor = data?.selected == ACTIVE ? .green:ColorUtils.gray_6()
            lbl_namefood.textColor = data?.selected == ACTIVE ? .white:.black
        }
    }
}
