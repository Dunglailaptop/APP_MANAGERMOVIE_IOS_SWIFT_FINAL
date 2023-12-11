//
//  PaymentBillViewController.swift
//  CinemaBook
//
//  Created by dungtien on 10/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
import JonAlert
import UserNotifications

class PaymentBillViewController: UIViewController {
    
   
    @IBOutlet weak var lbl_reduce: UILabel!
    @IBOutlet weak var view_no_data_voucher: UIView!
    @IBOutlet weak var tableviewvoucher: UITableView!
    var callPopViewController:() -> Void = {}
    @IBOutlet weak var image_check_2: UIImageView!
    @IBOutlet weak var image_check_1: UIImageView!
    @IBOutlet weak var image_check: UIImageView!
    @IBOutlet weak var btn_check_3: UIButton!
    @IBOutlet weak var btn_check_2: UIButton!
    @IBOutlet weak var btn_check_1: UIButton!
    @IBOutlet weak var lbl_total_amount_final: UILabel!
    @IBOutlet weak var lbl_total_amount_vat: UILabel!
    @IBOutlet weak var lbl_total_combofood: UILabel!
    @IBOutlet weak var lbl_total_chair_count: UILabel!
    @IBOutlet weak var lbl_total_amount_chair: UILabel!
    @IBOutlet weak var image_movie: UIImageView!
    
    @IBOutlet weak var lbl_dateshow: UILabel!
    @IBOutlet weak var lbl_name_movie: UILabel!
    
    @IBOutlet weak var lbl_chair: UILabel!
    @IBOutlet weak var lbl_total_bill: UILabel!
    @IBOutlet weak var lbl_combo: UILabel!
    @IBOutlet weak var lbl_name_room: UILabel!
    @IBOutlet weak var lbl_name_cinema: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var height_table:NSLayoutConstraint!
    @IBOutlet weak var height_combofoodadd:NSLayoutConstraint!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var height_scroll:NSLayoutConstraint!
    @IBOutlet weak var height_Table_voucher: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = PaymentBillViewModel()
    var router = PaymentBillRouter()
    var infoInterestMovie = InfoInterestMovie()
    var dataChair = [chair]()
    var dataFoodCombo = [FoodCombo]()
    var typeCheck = 0
    var TotalBill = 0
    var pointget = 0
    var Idbill = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view:self,router:router)
        register()
        bindingCollectioncell()
        registertable()
        bindingtablecell()
        registersVOUCHER()
        tableviewcellVOUCHER()
        checkbtn()
//        showNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name ("idbillcheckPaymentVNPAY"), object: nil)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListCombo()
        getPoint()
        setup()
       
    }
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any] {
                // Access the loginResponse dictionary here
                if let reportType = userInfo["userInfo"] as? [String: Any] {
                    let reportTypeValue = reportType["Report_type"] as? Int ?? 0
                    viewModel.idbill.accept(reportTypeValue)
                 
                       
                    getIdbill()
//                    viewModel.makePopToSuccessPayment()
//                    self.callPopViewController()
                    let notificationName = Notification.Name("POPTOVIEW")
                    let loginResponse = ["userInfo": []]
                    NotificationCenter.default.post(name: notificationName, object: nil, userInfo: loginResponse)
                }
            }
    }

    @IBAction func btn_makePopToviewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    @IBAction func btn_paymentbill(_ sender: Any) {
   
        typeCheck == 1 ?  saveCacheBILLVNPAY(): presentPopupPayment()
    }
    
}

