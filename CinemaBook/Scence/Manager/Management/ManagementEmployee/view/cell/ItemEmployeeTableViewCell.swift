//
//  ItemEmployeeTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/12/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemEmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var icon_lock: UIImageView!
    
    @IBOutlet weak var btn_unlock: UIButton!
    @IBOutlet weak var icon_resetpassword: UIImageView!
    @IBOutlet weak var btn_resetpassword: UIButton!
    @IBOutlet weak var btn_lockAccount: UIButton!
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var lbl_phone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data:Users? = nil {
        didSet {
            avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.avatar)), placeholder:  UIImage(named: "image_defauft_medium"))
            lbl_name.text = data!.fullname + " "
            if data?.statuss == 1 {
                contentView.backgroundColor = ColorUtils.gray_400()
                btn_resetpassword.isHidden = true
                icon_resetpassword.isHidden = true
                icon_lock.image = UIImage(named: "icon-unlock")
                btn_lockAccount.isHidden = true
                btn_unlock.isHidden = false
            }else {
                contentView.backgroundColor = .white
                btn_resetpassword.isHidden = false
                icon_resetpassword.isHidden = false
                icon_lock.image = UIImage(named: "icon-lock")
                btn_unlock.isHidden = true
                btn_lockAccount.isHidden = false
            }
        }
    }
    
    var viewModel: ManagementEmployeeViewModel? = nil {
        didSet{
           
        }
    }
    
    @IBAction func btn_makeToAccountinfoViewController(_ sender: Any) {
        self.viewModel!.makeToAccountinfo(iduser: data!.idusers,note: "UPDATE")
    }
}
