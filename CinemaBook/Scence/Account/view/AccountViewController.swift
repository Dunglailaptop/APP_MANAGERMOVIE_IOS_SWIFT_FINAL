//
//  AccountViewController.swift
//  CinemaBook
//
//  Created by dungtien on 7/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SKPhotoBrowser
import Kingfisher


class AccountViewController: BaseViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var lbl_name: UILabel!
    
    var viewModel = AccountViewModel()
    var router = AccountRouter()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        setup()
        // Do any additional setup after loading the view.
    }


    @IBAction func btn_actionlogout(_ sender: Any) {
    
//        self.remove()
        self.logout()
//        let view = LoginViewController();
//        self.navigationController?.pushViewController(view, animated: true)
//        self.logout()
//        self.viewModel.maketoLoginViewController()
    }
    
    func setup(){
        lbl_name.text = ManageCacheObject.getCurrentUserInfo().fullname
        avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: ManageCacheObject.getCurrentUserInfo().avatar)), placeholder:  UIImage(named: "image_defauft_medium"))
    }
    
}
