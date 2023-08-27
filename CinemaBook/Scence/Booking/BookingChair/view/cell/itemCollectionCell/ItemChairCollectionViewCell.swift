//
//  ItemChairCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemChairCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var lbl_numberChair: UILabel!
    var number:Int = 0 {
        didSet {
             lbl_numberChair.text = String(number)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    
}
