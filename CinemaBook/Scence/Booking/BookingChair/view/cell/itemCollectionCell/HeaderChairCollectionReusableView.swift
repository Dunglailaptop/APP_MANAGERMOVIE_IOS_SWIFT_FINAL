//
//  HeaderChairCollectionReusableView.swift
//  CinemaBook
//
//  Created by dungtien on 8/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class HeaderChairCollectionReusableView: UICollectionReusableView {

    
    // Initialize and configure UI elements here
       let titleLabel = UILabel()

       override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }

       private func commonInit() {
           // Configure UI elements, layout, and constraints
           titleLabel.text = "Header Title"
           addSubview(titleLabel)
           // Add constraints...
       }

       func configure() {
           // Configure the content of the header view here
           titleLabel.text = "Updated Header Title"
       }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension HeaderChairCollectionReusableView {
   
}
