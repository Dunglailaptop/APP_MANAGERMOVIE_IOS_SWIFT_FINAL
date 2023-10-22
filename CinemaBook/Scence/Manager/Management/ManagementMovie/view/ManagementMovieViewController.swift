//
//  ManagementMovieViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/14/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class ManagementMovieViewController: BaseViewController {

   
    @IBOutlet weak var view_History: UIView!
    @IBOutlet weak var lbl_viewControllerHistory: UILabel!
    
    
    @IBOutlet weak var view_New: UIView!
    @IBOutlet weak var lbl_viewControllerNew: UILabel!
    var viewModel = ManagementMovieViewModel()
    var router = ManagementMovieRouter()
    var view1 = ListMovieShowNowViewController()
    var view2 = ListMovieShowNowViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        self.view_history()

        // Do any additional setup after loading the view.
    }


    @IBAction func btn_viewControllerhistory(_ sender: Any) {
        self.view_history()
    }
    
    @IBAction func btn_viewControllerNew(_ sender: Any) {
        self.view_new()
    }
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopTovViewController()
    }
    
    @IBAction func btn_makeToDetailViewController(_ sender: Any) {
        viewModel.makeToManagementDetailViewController()
    }
    
  
    
    func view_history(){
        lbl_viewControllerHistory.textColor = ColorUtils.blueLabel()
        view_History.backgroundColor = ColorUtils.blue_textbutton()
        view_New.backgroundColor = ColorUtils.gray_200()
        lbl_viewControllerNew.textColor = ColorUtils.gray_600()
        addTopCustomViewController(view1, addTopCustom: 110)
        view1.Type_edit = 2
        view1.type_viewTralling = 1
        view1.status = 3

        view2.remove()
    }
    
    func view_new() {
        lbl_viewControllerNew.textColor = ColorUtils.blueLabel()
        view_New.backgroundColor = ColorUtils.blue_textbutton()
        view_History.backgroundColor = ColorUtils.gray_200()
        lbl_viewControllerHistory.textColor = ColorUtils.gray_600()
        view2.Type_edit = 1
        view2.type_viewTralling = 1
        view2.status = 0
        addTopCustomViewController(view2, addTopCustom: 110)
        view1.remove()
    }
}
