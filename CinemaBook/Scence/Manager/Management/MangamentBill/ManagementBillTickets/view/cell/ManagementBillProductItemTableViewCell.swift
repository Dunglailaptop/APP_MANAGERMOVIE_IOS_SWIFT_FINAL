//
//  ManagementBillProductItemTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 16/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementBillProductItemTableViewCell: UITableViewCell {

    @IBOutlet weak var view_status: UIButton!
    @IBOutlet weak var lbl_date_createbill: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_chair_list: UILabel!
    @IBOutlet weak var lbl_name_movie: UILabel!
    @IBOutlet weak var lbl_id_bill: UILabel!
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
            if data?.statusbill == 0 {
              
                view_status.setTitle("CHỜ XEM", for: .normal)
                view_status.backgroundColor = .red
            }else {
                view_status.setTitle("HOÀN TẤT", for: .normal)
                view_status.backgroundColor = .green
            }
            var datatime = data?.starttime.components(separatedBy: "T")
            lbl_date.text = datatime![0]
            lbl_time.text = datatime![1]
            var datebillcreate = data?.datebill.components(separatedBy: "T")
            lbl_date_createbill.text = "Ngày tạo: " + datebillcreate![0]
            lbl_name_movie.text = data?.namemovie
            lbl_id_bill.text = "Mã hoá đơn:" + String(data!.idbill)
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.totalamount)
            image_avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
        }
    }
    
}
