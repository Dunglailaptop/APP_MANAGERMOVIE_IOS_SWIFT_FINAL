//
//  ItemRoomBillTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 04/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemRoomBillTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_total_chairs: UILabel!
    @IBOutlet weak var lbl_name_room: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var data:Room? = nil {
        didSet {
            lbl_total_chairs.text = String(data!.allchair)
            lbl_name_room.text = data?.nameroom
        }
    }
    
}
