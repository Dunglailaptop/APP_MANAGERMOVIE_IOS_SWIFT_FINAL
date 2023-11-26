//
//  ItemCinemasTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 26/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemCinemasTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name_cinema: UILabel!
    @IBOutlet weak var cinema: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: Cinema? = nil {
        didSet{
            lbl_name_cinema.text = data?.namecinema
            cinema.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder:  UIImage(named: "image_defauft_medium"))
        }
    }
    
}
