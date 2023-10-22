//
//  itemMovieTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class itemMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var view_trallsing_edit: UIView!
    @IBOutlet weak var view_cancel: UIView!
    @IBOutlet weak var view_button_edit: UIStackView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_dateshow: UILabel!
    @IBOutlet weak var lbl_timeshow: UILabel!
    @IBOutlet weak var height_button: NSLayoutConstraint!
    @IBOutlet weak var poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
         lbl_name.adjustsFontSizeToFitWidth = true
        view_trallsing_edit.roundCorners(corners: [.topLeft,.bottomLeft], radius: CGFloat(5))
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
               var date = data?.yearbirthday.components(separatedBy: "T")
               lbl_dateshow.text = "Ngày công chiếu: " + date![0]
               lbl_timeshow.text = String(data!.timeall) + "Phút"
               switch data?.statusshow {
               case 1:
                   view_cancel.isHidden = true
               case 2:
                   view_cancel.isHidden = true
               case 3:
                   view_cancel.isHidden = false
               default:
                   view_cancel.isHidden = true
               }
           }
       }
       
     
       
       var viewModel:ListMovieShowNowViewModel? = nil{
           didSet{
               
           }
       }
    
    
    @IBAction func btn_makeToDetailViewController(_ sender: Any) {
        switch viewModel?.view?.Type_edit {
        case 1:
            viewModel?.makeToManagementDetailViewController(id: data!.movieID)
        case 2:
            viewModel?.makeToManagementDetailViewController(id: data!.movieID)
        default:
            viewModel?.makeToDetailMovieViewController(id: data!.movieID)
        }
          
       }
}
