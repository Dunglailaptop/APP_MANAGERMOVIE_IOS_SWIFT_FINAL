//
//  ItemRoomChooseCollectionViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 18/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemRoomChooseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_name_room: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    var data:Room? = nil {
        didSet {
            lbl_name_room.text = data?.nameroom
            self.lbl_name_room.backgroundColor = data?.isSelected == ACTIVE ? .green: ColorUtils.gray_6()
            self.lbl_name_room.textColor = data?.isSelected == ACTIVE ? .white: .black
        }
    }
    
}
