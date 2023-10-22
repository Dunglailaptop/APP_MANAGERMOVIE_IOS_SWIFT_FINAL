//
//  ManagementMovieViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/14/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementMovieViewController: BaseViewController {

    @IBOutlet weak var btn_search: UIButton!
    @IBOutlet weak var view_History: UIView!
    @IBOutlet weak var lbl_viewControllerHistory: UILabel!
    
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var view_New: UIView!
    @IBOutlet weak var lbl_viewControllerNew: UILabel!
    var viewModel = ManagementMovieViewModel()
    var router = ManagementMovieRouter()
    
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
    
    @IBAction func btn_show_search(_ sender: Any) {
        view_search.isHidden = false
        
    }
    @IBAction func btn_close_view_search(_ sender: Any) {
        view_search.isHidden = true
    }
    
    func view_history(){
                lbl_viewControllerHistory.textColor = ColorUtils.blueLabel()
                view_History.backgroundColor = ColorUtils.blue_textbutton()
                view_New.backgroundColor = ColorUtils.gray_200()
                lbl_viewControllerNew.textColor = ColorUtils.gray_600()
                let ListMovieShowNowViewControllers = ListMovieShowNowViewController(nibName: "ListMovieShowNowViewController", bundle: Bundle.main)
                ListMovieShowNowViewControllers.status = 1
                ListMovieShowNowViewControllers.Type_edit = 1
                addTopCustomViewController(ListMovieShowNowViewControllers, addTopCustom: 160)
                let ListMovieShowNowViewControllerss = ListMovieShowNowViewController(nibName: "ListMovieShowNowViewController", bundle: Bundle.main)
                ListMovieShowNowViewControllerss.remove()
    }
    
    func view_new() {
        lbl_viewControllerNew.textColor = ColorUtils.blueLabel()
                  view_New.backgroundColor = ColorUtils.blue_textbutton()
              view_History.backgroundColor = ColorUtils.gray_200()
              lbl_viewControllerHistory.textColor = ColorUtils.gray_600()
              let ListMovieShowNowViewControllers = ListMovieShowNowViewController(nibName: "ListMovieShowNowViewController", bundle: Bundle.main)
                  ListMovieShowNowViewControllers.status = 0
                      
                        addTopCustomViewController(ListMovieShowNowViewControllers, addTopCustom: 160)
                  let ListMovieShowNowViewControllerss = ListMovieShowNowViewController(nibName: "ListMovieShowNowViewController", bundle: Bundle.main)
                        ListMovieShowNowViewControllerss.remove()
    }
}
