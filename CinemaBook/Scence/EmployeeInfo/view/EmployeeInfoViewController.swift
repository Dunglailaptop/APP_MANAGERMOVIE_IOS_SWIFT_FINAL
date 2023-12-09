//
//  EmployeeInfoViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 05/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class EmployeeInfoViewController: UIViewController {

    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var lbl_username: UILabel!
    
    @IBOutlet weak var lbl_datebirthday: UILabel!
    
    @IBOutlet weak var lbl_gender: UILabel!
    
    @IBOutlet weak var lbl_email: UILabel!
    
    @IBOutlet weak var lbl_fullname: UILabel!
    
    @IBOutlet weak var txt_address: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
          setup()
        // Do any additional setup after loading the view.
    }

    func setup() {
        lbl_username.text = ManageCacheObject.getCurrentUserInfo().fullname
        lbl_email.text = ManageCacheObject.getCurrentUserInfo().email
        lbl_datebirthday.text = ManageCacheObject.getCurrentUserInfo().birthday
        lbl_gender.text = ManageCacheObject.getCurrentUserInfo().gender == 0 ? "Nam":"Nữ"
        lbl_fullname.text = ManageCacheObject.getCurrentUserInfo().fullname
        avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: ManageCacheObject.getCurrentUserInfo().avatar)), placeholder: UIImage(named: "image_defauft_medium"))
        txt_address.text = ManageCacheObject.getCurrentUserInfo().address
        
    }


}
