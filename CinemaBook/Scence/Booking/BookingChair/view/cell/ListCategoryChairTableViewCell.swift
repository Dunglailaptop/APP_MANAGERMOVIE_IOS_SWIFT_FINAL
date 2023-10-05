//
//  ListCategoryChairTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/27/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ListCategoryChairTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: BookingChairViewModel? = nil {
        didSet {
            
        }
    }
    
}
extension ListCategoryChairTableViewCell {
    func register() {
        
    }
    
    func bindingCollectionviewcell() {
        
    }
}
