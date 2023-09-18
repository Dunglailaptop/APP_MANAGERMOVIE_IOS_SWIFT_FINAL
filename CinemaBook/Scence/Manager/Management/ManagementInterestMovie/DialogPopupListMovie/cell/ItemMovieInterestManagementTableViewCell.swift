//
//  ItemMovieInterestManagementTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/18/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemMovieInterestManagementTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_timeMovie: UILabel!
    @IBOutlet weak var namemovie: UILabel!
    @IBOutlet weak var avatar_movie: UIImageView!
    @IBOutlet weak var iconcheck: UIImageView!
    @IBOutlet weak var btn_button_check: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data:Movie? = nil{
        didSet{
            namemovie.text = data?.namemovie
            lbl_timeMovie.text = String(data!.timeall)
            avatar_movie.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
            if data?.ischeck == 0 {
                iconcheck.image = UIImage(named: "icon-check-disable")
            } else {
                     iconcheck.image = UIImage(named: "check_2")
            }
        }
    }
    
}
