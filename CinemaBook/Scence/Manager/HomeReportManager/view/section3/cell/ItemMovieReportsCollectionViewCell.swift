//
//  ItemMovieReportsCollectionViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 01/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import MarqueeLabel

class ItemMovieReportsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image_movie: UIImageView!
    @IBOutlet weak var view_all: UIView!
    @IBOutlet weak var lbl_name_movie: MarqueeLabel!
    @IBOutlet weak var lbl_stt: UILabel!
    @IBOutlet weak var view_color: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
