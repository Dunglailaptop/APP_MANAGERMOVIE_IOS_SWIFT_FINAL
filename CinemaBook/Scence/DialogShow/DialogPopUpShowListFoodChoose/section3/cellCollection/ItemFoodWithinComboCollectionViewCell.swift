//
//  ItemFoodWithinComboCollectionViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 12/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemFoodWithinComboCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image_food: UIImageView!
    
    @IBOutlet weak var name_food: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     
//    var data: Food? = nil {
//        didSet {
//            name_food.text = data?.namefood
//            image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder:  UIImage(named: "image_defauft_medium"))
//        }
//    }
    
}
