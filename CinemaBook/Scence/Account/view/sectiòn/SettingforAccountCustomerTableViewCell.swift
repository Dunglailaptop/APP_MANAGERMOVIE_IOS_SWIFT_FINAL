//
//  SettingforAccountCustomerTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/31/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class SettingforAccountCustomerTableViewCell: UITableViewCell {

    @IBOutlet weak var view_bill_product: UIImageView!
    @IBOutlet weak var view_bill_tickets: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any] {
                // Access the loginResponse dictionary here
                if let reportType = userInfo["userInfo"] as? [String: Any] {
                    let reportTypeValue = reportType["Report_type"] as? numberNotifaction
                    dLog(reportTypeValue)
                    view_bill_product.setBadge(value: String(reportTypeValue!.numberbillfood))
                    view_bill_tickets.setBadge(value: String(reportTypeValue!.numberbill))
                }
            }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
    var viewModel: AccountViewModel? = nil {
        didSet {
            NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name ("MESSAGENOTIFACTION"), object: nil)
        }
    }
    
    
    @IBAction func btn_makeToManageBillPayment(_ sender: Any) {
        viewModel?.makeToManageBillAccountViewController()
    }
        
    @IBAction func btn_makeToBillFoodListAccount(_ sender: Any) {
        viewModel?.makeToManageBillFoodListViewController()
    }
    
    @IBAction func btn_makeToForgoViewController(_ sender: Any) {
        viewModel?.makeToForgotViewController()
    }
    
}
