//
//  ManagementInterestMoviesTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 17/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementInterestMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var view_cancel: UIView!
    @IBOutlet weak var view_time: UIView!
    @IBOutlet weak var lbl_timestart_timeend: UILabel!
    @IBOutlet weak var lbl_timeallshowinmovie: UILabel!
    @IBOutlet weak var view_edit: UIView!
    @IBOutlet weak var lbl_name_movie: UILabel!
    @IBOutlet weak var image_avatar: UIImageView!
    @IBOutlet weak var lbl_time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .lightGray
        view_time.backgroundColor = .lightGray
        // Configure the view for the selected state
    }
    
    var data: MovieList? = nil {
        didSet {
            if data?.status == 1 {
            
                view_cancel.isHidden = false
            }else {
                view_cancel.isHidden = true
                
            }
            dLog(data)
            self.image_avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.image)), placeholder:  UIImage(named: "image_defauft_medium"))
            var datatime = data?.startTime.components(separatedBy: "T")
            var datatimeend = data?.endTime.components(separatedBy: "T")
            var dataComponent = datatime![1].components(separatedBy: ":")
            var dataComponentEnd = datatimeend![1].components(separatedBy: ":")
            var times = dataComponent[0] + ":" + dataComponent[1]
            var timesend = dataComponentEnd[0] + ":" + dataComponentEnd[1]
            lbl_time.text = times
            lbl_name_movie.text = data?.namemovie
            lbl_timeallshowinmovie.text = String(data!.alltime) + "P"
            lbl_timestart_timeend.text = times + "-" + timesend
            
        }
    }
    
    
}
