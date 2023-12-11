//
//  SystemitemCheckinTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class SystemitemCheckinTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lbl_timeend: UILabel!
    @IBOutlet weak var lbl_timestart: UILabel!
    @IBOutlet weak var lbl_idnv: UILabel!
    @IBOutlet weak var LBL_name_employee: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var data: Datacheckin? = nil {
        didSet {
            LBL_name_employee.text = data?.nameusers
            lbl_idnv.text = "ID:" + String(data!.idusers)
            var time1 = data?.timestart.components(separatedBy: "T")
            var time2 = data?.timeend.components(separatedBy: "T")
            lbl_timestart.text = time1?[1]
            lbl_timeend.text = time2?[1]
            avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.avatar)), placeholder: UIImage(named: "image_defauft_medium"))
        }
    }
}
