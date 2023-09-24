//
//  ItemCategoryChairCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemCategoryChairCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var view_color_chair: UIView!
    @IBOutlet weak var llb_namechair: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var data: CategoryChair? = nil {
        didSet {
            llb_namechair.text = data?.namecategorychair
            if data?.colorchair == "1" {
                view_color_chair.backgroundColor = .systemGray
            }
        }
    }
}
