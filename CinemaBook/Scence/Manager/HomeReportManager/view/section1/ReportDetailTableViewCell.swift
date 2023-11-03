//
//  ReportDetailTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import ObjectMapper

class ReportDetailTableViewCell: UITableViewCell {
   
    @IBOutlet weak var lbl_total_all: UILabel!
    
    @IBOutlet weak var lbl_total_ticket: UILabel!
    
    @IBOutlet weak var lbl_total_foodwithbill: UILabel!
    
    @IBOutlet weak var lbl_total_food: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: HomeReportviewModel? = nil {
        didSet {
            getReportDetail()
        }
    }

}

extension ReportDetailTableViewCell {
    func getReportDetail() {
        viewModel!.getReportDetailAll().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<reportDetail>().map(JSONObject: response.data) {
                    self.lbl_total_all.text = Utils.stringVietnameseFormatWithNumber(amount: data.totalall)
                    self.lbl_total_food.text = Utils.stringQuantityFormatWithNumber(amount: data.totalfood)
                    self.lbl_total_ticket.text = Utils.stringQuantityFormatWithNumber(amount: data.totalticket)
                    self.lbl_total_foodwithbill.text = Utils.stringQuantityFormatWithNumber(amount: data.totalfoodcombowith)
                }
            }
        })
    }
}
