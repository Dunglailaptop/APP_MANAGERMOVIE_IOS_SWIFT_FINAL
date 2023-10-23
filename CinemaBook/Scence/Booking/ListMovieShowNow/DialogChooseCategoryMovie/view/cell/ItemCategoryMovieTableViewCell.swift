//
//  ItemCategoryMovieTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 22/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemCategoryMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_namecategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: CategoryMovie? = nil {
        didSet {
            lbl_namecategory.text = data?.namecategorymovie
        }
    }
    
}
