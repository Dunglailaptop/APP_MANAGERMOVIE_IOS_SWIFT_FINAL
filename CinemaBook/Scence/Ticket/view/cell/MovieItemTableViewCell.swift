//
//  MovieItemTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/6/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class MovieItemTableViewCell: UITableViewCell {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_actionNavigation(_ sender: Any) {
        let view = LoginViewController()
        
    }
    
    
}
