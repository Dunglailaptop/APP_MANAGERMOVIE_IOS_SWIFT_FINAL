//
//  ItemInterestMovieListManagementCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/23/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ItemInterestMovieListManagementCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image_check: UIImageView!
  
    @IBOutlet weak var lbl_timeall: UILabel!
    @IBOutlet weak var lbl_name_movie: UILabel!
    @IBOutlet weak var image_avater: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_name_movie.adjustsFontSizeToFitWidth = true
        // Initialization code
    }
    
    var viewModel: ManagementInterestMoviesViewModel? = nil {
        didSet {
           
        }
    }

    var data: Movie? = nil {
        didSet {
            dLog(data?.isSelected)
            lbl_name_movie.text = data?.namemovie
            image_avater.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
            lbl_timeall.text = "Thời gian:" + String(data!.timeall) + "p"
            image_check.image = UIImage(named: data?.isSelected == ACTIVE ? "check":"icon-check-disable")

        }
    }
    
    
}
