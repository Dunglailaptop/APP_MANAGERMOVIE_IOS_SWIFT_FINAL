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
    
    @IBOutlet weak var lbl_username_account: UILabel!
    @IBOutlet weak var lbl_point_account: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_name: UILabel!
    
    var viewModel = AccountViewModel()
    var router = AccountRouter()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        register()
        bindingtableview()
        setup()
        if ManageCacheObject.getCurrentUserInfo().idrole == 2 || ManageCacheObject.getCurrentUserInfo().idrole == 3 {
            viewModel.dataArray.accept([0,1])
        }else {
            viewModel.dataArray.accept([0,1,2])
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_point_account.text = Utils.stringQuantityFormatWithNumber(amount: ManageCacheObject.getCurrentUserInfo().point)
        lbl_username_account.text = ManageCacheObject.getCurrentUserInfo().username
    }


    @IBAction func btn_actionlogout(_ sender: Any) {
    

        self.logout()
        

    }

    
    func setup(){
        lbl_name.text = ManageCacheObject.getCurrentUserInfo().fullname
        avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: ManageCacheObject.getCurrentUserInfo().avatar)), placeholder:  UIImage(named: "image_defauft_medium"))
    }
    
    @IBAction func bnt_makeToAccountinfoviewcontroller(_ sender: Any) {
        viewModel.makeToAccountInfoViewController()
    }
}
