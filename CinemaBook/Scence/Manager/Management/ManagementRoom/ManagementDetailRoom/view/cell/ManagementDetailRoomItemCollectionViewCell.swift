//
//  ManagementDetailRoomItemCollectionViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 24/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementDetailRoomItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_name_chair: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var data: chair? = nil {
        didSet {
            lbl_name_chair.text =  String(data!.numberChair)
            + String(data!.rowChar) 
        }
    }

}
