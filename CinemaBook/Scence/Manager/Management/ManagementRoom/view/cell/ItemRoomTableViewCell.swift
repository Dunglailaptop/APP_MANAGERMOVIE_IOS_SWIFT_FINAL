//
//  ItemRoomTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 23/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemRoomTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_number_room: UILabel!
    @IBOutlet weak var lbl_name_room: UILabel!
    @IBOutlet weak var lbl_id_room: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: Room? = nil {
        didSet{
            lbl_name_room.text = "Tên rạp: " + String(data!.nameroom)
            lbl_id_room.text = "Mã phòng: " + String(data!.idroom)
            lbl_number_room.text = "Số lượng ghế: " + String(data!.allchair)
        }
    }
    
}
