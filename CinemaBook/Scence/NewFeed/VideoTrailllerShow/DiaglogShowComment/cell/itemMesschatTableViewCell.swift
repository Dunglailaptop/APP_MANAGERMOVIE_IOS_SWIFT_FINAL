//
//  itemMesschatTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class itemMesschatTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_message: UILabel!
    @IBOutlet weak var lbl_nameuser: UILabel!
    @IBOutlet weak var avatar_image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var data: Comments? = nil {
        didSet {
            avatar_image.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.image)), placeholder: UIImage(named: "image_defauft_medium"))
            lbl_message.text = data?.message
            lbl_nameuser.text = data?.nameuser
        }
    }
}
