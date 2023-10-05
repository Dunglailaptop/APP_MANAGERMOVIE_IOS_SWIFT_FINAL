//
//  ItemCollectionProductCategoryCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemCollectionProductCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_namecategoryfood: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var data: CategoryFood? = nil {
        didSet {
            lbl_namecategoryfood.text = data?.namecategoryfood
        }
    }
}
