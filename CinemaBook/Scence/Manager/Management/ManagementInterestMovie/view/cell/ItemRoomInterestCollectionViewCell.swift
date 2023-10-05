//
//  ItemRoomInterestCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemRoomInterestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btn_chooseRoom: UIButton!
    @IBOutlet weak var lbl_name_room: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var data:Room? = nil {
        didSet{
            lbl_name_room.text = data?.nameroom
        }
    }
}
