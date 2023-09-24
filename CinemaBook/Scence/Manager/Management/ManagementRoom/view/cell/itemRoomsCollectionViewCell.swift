//
//  itemRoomsCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class itemRoomsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_nameRoom: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    var data:Room? = nil {
        didSet {
            lbl_nameRoom.text = data?.nameroom
        }
    }
}
