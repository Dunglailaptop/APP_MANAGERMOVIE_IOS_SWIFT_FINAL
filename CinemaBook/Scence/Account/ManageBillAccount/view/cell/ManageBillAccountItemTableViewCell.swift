//
//  ManageBillAccountItemTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 15/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManageBillAccountItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_time_interest: UILabel!
    @IBOutlet weak var lbl_date_interest: UILabel!
    @IBOutlet weak var lbl_number_chair: UILabel!
    @IBOutlet weak var lbl_name_movie: UILabel!
    @IBOutlet weak var image_avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: BillInfoAccount? = nil {
        didSet {
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.totalamount)
            lbl_name_movie.text = data?.namemovie
            var timeshow = data?.starttime.components(separatedBy: "T")
            image_avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
            lbl_date_interest.text = timeshow![0]
            lbl_time_interest.text = timeshow![1]
            
        }
    }
    
}
