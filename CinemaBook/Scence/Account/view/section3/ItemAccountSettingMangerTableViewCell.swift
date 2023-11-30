//
//  ItemAccountSettingMangerTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 17/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemAccountSettingMangerTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var viewModel:  AccountViewModel? = nil {
        didSet{
            
        }
    }
    
    @IBAction func btn_makeToSettingBusiness(_ sender: Any) {
        viewModel?.makeToSettingBusiness()
    }
    
    @IBAction func btn_makeToForgotPassword(_ sender: Any) {
        viewModel?.makeToForgotPassword()
    }
}
