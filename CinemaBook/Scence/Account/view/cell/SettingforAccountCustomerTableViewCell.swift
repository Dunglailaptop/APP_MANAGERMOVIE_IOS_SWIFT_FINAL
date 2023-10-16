//
//  SettingforAccountCustomerTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/31/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class SettingforAccountCustomerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: AccountViewModel? = nil {
        didSet {
            
        }
    }
    
    
    @IBAction func btn_makeToManageBillPayment(_ sender: Any) {
        viewModel?.makeToManageBillAccountViewController()
    }
        
    @IBAction func btn_makeToBillFoodListAccount(_ sender: Any) {
        viewModel?.makeToManageBillFoodListViewController()
    }
}
