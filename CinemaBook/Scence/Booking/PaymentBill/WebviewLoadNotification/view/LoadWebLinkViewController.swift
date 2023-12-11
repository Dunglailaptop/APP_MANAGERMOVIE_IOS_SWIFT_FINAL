//
//  LoadWebLinkViewController.swift
//  ALOLINE
//
//  Created by Kelvin on 06/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import WebKit

class LoadWebLinkViewController: BaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var title_header = "CHƯƠNG TRÌNH KHUYẾN MÃI"
    var link = "https://123-zo.vn/intro-hau.html"
    @IBOutlet weak var lbl_title_header: UILabel!
    //  var webView: WKWebView!
    var idbill = 0
    var callPopViewController:() -> Void = {}
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_title_header.text = title_header 
     
    }
   
    
    @IBAction func actionBack(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
       if  type == "Paymentfood"
        {
           self.navigationController?.popViewController(animated: true)
       }else {
           self.callPopViewController()
       }
       
        let notificationName = Notification.Name("idbillcheckPaymentVNPAY")
        let loginResponse = ["userInfo": ["Report_type": idbill]]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: loginResponse)
        
    }
}
