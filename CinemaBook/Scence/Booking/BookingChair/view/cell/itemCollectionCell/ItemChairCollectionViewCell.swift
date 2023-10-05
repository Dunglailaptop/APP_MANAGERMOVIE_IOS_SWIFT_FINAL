//
//  ItemChairCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemChairCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var btn_choose_chair: UIButton!
    @IBOutlet weak var lbl_numberChair: UILabel!
    var data:chair? = nil {
        didSet {
            if data?.isSelected == BILL {
                contentView.backgroundColor = .red
            } else if data?.isSelected == ACTIVE {
                contentView.backgroundColor = .blue
            } else {
                contentView.backgroundColor = .clear
            }
            lbl_numberChair.text = String(String(data!.numberChair)+data!.rowChar)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    
}
