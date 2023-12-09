//
//  DialogshowCheckinViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 08/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift
import ObjectMapper
import JonAlert

class DialogshowCheckinViewController: BaseViewController {

    @IBOutlet weak var lbl_info: UILabel!
    var router = DialogshowCheckinRouter()
    var viewModel = DialogshowCheckinViewModel()
    var checkins = checkin()
    var type = 0
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
         // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.datacheckin.accept(checkins)
    }
    
  

    @IBAction func btn_access(_ sender: Any) {
        checkinaccs()
    }
    
    @IBAction func btn_cancel(_ sender: Any) {
        self.logout()
        
    }
    
}
extension DialogshowCheckinViewController {
    func checkinaccs() {
        viewModel.checkins().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
             
                   
                if let data = Mapper<checkin>().map(JSONObject: response.data) {
                    if self.type == 1{
                        let time = data.timestart.components(separatedBy: "T")
                        JonAlert.showSuccess(message: response.message! + time[1] ?? "có lỗi xảy ra")
                        self.dismiss(animated: true)
                    }else {
                        self.logout()
                    }
                }
                    
                
               
            } else {
                dLog(response.message)
            }
        })
    }
}
