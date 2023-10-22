//
//  itemMovieTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class itemMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_dateshow: UILabel!
    @IBOutlet weak var lbl_timeshow: UILabel!
    @IBOutlet weak var height_button: NSLayoutConstraint!
    @IBOutlet weak var poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
         lbl_name.adjustsFontSizeToFitWidth = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data:Movie? = nil {
           didSet {
               poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
               lbl_name.text = data?.namemovie
           
           }
       }
       
     
       
       var viewModel:ListMovieShowNowViewModel? = nil{
           didSet{
               
           }
       }
    
    
    @IBAction func btn_makeToDetailViewController(_ sender: Any) {
           viewModel?.makeToDetailMovieViewController(id: data!.movieID)
       }
}
