//
//  ItemMovieReportTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 01/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import MarqueeLabel

class ItemMovieReportTableViewCell: UITableViewCell {

   
    @IBOutlet weak var lbl_number: UILabel!
    @IBOutlet weak var view_color: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
