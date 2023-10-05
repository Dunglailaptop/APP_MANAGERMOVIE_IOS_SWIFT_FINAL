//
//  ItemProductOrderCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemProductOrderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image_product: UIImageView!
    
    @IBOutlet weak var lbl_name_product: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var data: FoodCombo? = nil {
        didSet{
            lbl_name_product.text = data?.nametittle
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.priceCombo )
            image_product.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder: UIImage(named: "image_defauft_medium"))
        }
    }
    
}
