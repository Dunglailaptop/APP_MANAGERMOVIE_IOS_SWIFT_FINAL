//
//  ManagementViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/10/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManagementViewController: BaseViewController {

    var viewModel = ManagementViewModel()
    var router = ManagementRouter()
    var view1 = ManagementBillViewController()
    
    @IBOutlet weak var view_management: UIView!
    @IBOutlet weak var lbl_management: UILabel!
    @IBOutlet weak var view_bill: UIView!
    @IBOutlet weak var lbl_bill: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgisterViewController()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btn_ManagementViewController(_ sender: Any) {
      managementViewController()
    }
    
    @IBAction func btn_ManagementBillViewController(_ sender: Any) {
       BilviewController()
    }
    
    func resgisterViewController() {
       
        view1 = ManagementBillViewController(nibName: "ManagementBillViewController", bundle: .main) as! ManagementBillViewController
       managementViewController()
    }
    
    func BilviewController() {
        lbl_bill.textColor = ColorUtils.blueLabel()
        view_bill.backgroundColor = ColorUtils.blue_textbutton()
        lbl_management.textColor = ColorUtils.gray_600()
        view_management.backgroundColor = .clear
          addTopCustomViewController(view1, addTopCustom: 70)
    }
    func managementViewController() {
        lbl_bill.textColor = ColorUtils.gray_600()
        view_bill.backgroundColor = .clear
        lbl_management.textColor = ColorUtils.blueLabel()
        view_management.backgroundColor = ColorUtils.blue_textbutton()
        view1.remove()
    }
    
    @IBAction func btn_makeToManageEmployeeViewContrller(_ sender: Any) {
        viewModel.navigationToManagementEmployee()
    }
   
    @IBAction func btn_makeToManagemnetMovieViewController(_ sender: Any) {
        viewModel.navigationToManagementMovie()
    }
    
    @IBAction func btn_makeToManagementInterestMovie(_ sender: Any) {
        viewModel.navigationToManagementMovieInterest()
    }
    
 
    @IBAction func btn_makeToManagementRoomViewController(_ sender: Any) {
        viewModel.navigationToManagementRoomViewController()
    }
    
    @IBAction func btn_ManagementProduct(_ sender: Any) {
        viewModel.navigationToManagementProductViewController()
    }
    
    @IBAction func btn_makeToVoucherManagement(_ sender: Any) {
        viewModel.navigaionToManagementVoucher()
    }
    
}
