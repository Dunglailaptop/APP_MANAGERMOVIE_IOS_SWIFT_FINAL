//
//  ItemMovieCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/13/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import Kingfisher


class ItemMovieCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var view_avatar: UIImageView!
    
    @IBOutlet weak var lbl_name_movie: UILabel!
    
    @IBOutlet weak var lbl_timeall: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_name_movie.adjustsFontSizeToFitWidth = true
        // Initialization code
    }
    
    var data:Movie? = nil {
        didSet {
            view_avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
            lbl_name_movie.text = data?.namemovie
            lbl_timeall.text = String(data!.timeall)
        }
    }
    
  
    
    var viewModel:BookingViewModel? = nil{
        didSet{
            
        }
    }

    @IBAction func btn_makeToDetailViewController(_ sender: Any) {
        viewModel?.makeToDetailMovieViewController(id: data!.movieID)
    }
}

extension ItemMovieCollectionViewCell {
   
}
