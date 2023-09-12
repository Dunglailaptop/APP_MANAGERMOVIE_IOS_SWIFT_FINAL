//
//  ItemEmployeeTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/12/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemEmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var lbl_phone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data:Users? = nil {
        didSet {
            avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.avatar)), placeholder:  UIImage(named: "image_defauft_medium"))
            lbl_name.text = data!.fullname + " "
        }
    }
    
}
