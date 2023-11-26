//
//  ItemNoTiFactionTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemNoTiFactionTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_message: UILabel!
    @IBOutlet weak var image_logo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: notifaction? = nil {
        didSet{
            var time = data?.datecreate.components(separatedBy: "T")
            lbl_message.text = data?.messages
            lbl_time.text = time![1]
        }
    }
}
