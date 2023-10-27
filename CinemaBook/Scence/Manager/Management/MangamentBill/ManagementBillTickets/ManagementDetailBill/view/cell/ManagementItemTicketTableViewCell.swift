//
//  ManagementItemTicketTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 26/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementItemTicketTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_price_chair: UILabel!
    @IBOutlet weak var lbl_name_chair: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: DetailTicket? = nil {
        didSet {
            lbl_price_chair.text = Utils.stringVietnameseFormatWithNumber(amount: data!.price)
            lbl_name_chair.text = data?.namechair
        }
    }
    
}
