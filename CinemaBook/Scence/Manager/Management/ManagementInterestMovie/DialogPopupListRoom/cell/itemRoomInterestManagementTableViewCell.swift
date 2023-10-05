//
//  itemRoomInterestManagementTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/18/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class itemRoomInterestManagementTableViewCell: UITableViewCell {

   
    @IBOutlet weak var image_status: UIImageView!
    @IBOutlet weak var lbl_total_chair: UILabel!
    @IBOutlet weak var lbl_name_room: UILabel!
    @IBOutlet weak var avatar_room: UIImageView!
    @IBOutlet weak var btn_check: UIButton!
    @IBOutlet weak var image_check: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: Room?  {
        didSet{
            lbl_name_room.text = data?.nameroom
            lbl_total_chair.text = "SL: " + String(data!.allchair)
            if data?.ischeck == 0 {
                       image_check.image = UIImage(named: "icon-check-disable")
                   } else {
                        image_check.image = UIImage(named: "check_2")
                   }
        }
       
    }
}
