//
//  FlimsCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 7/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class FlimsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var image_poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var viewModel: HomeViewModel? = nil {
        didSet {
            
        }
    }
    
    var data: Movie? = nil {
        didSet {
            lbl_title.text = data?.namemovie
            self.image_poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
        }
    }
    
}
