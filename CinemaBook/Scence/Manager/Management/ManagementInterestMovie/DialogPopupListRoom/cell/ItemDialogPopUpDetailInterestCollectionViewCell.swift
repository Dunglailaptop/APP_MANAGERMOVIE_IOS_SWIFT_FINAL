//
//  ItemDialogPopUpDetailInterestCollectionViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 19/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemDialogPopUpDetailInterestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var data: Movie? = nil {
        didSet {
            lbl_name.text = data?.namemovie
            poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
        }
    }

}
