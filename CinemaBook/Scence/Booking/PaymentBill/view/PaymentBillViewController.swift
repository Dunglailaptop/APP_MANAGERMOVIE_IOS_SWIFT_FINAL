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

class PaymentBillViewController: UIViewController {
    
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
    @IBOutlet weak var tableView: UITableView!
    var viewModel = PaymentBillViewModel()
    var router = PaymentBillRouter()
    var infoInterestMovie = InfoInterestMovie()
    var dataChair = [chair]()
    var dataFoodCombo = [FoodCombo]()
    var typeCheck = 0
    var TotalBill = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view:self,router:router)
        register()
        bindingCollectioncell()
        registertable()
        bindingtablecell()
        checkbtn()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListCombo()
        setup()
    }

    @IBAction func btn_makePopToviewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    @IBAction func btn_paymentbill(_ sender: Any) {
        typeCheck == 1 ? presentPopupPayment() : presentPopupNotPayment()
    }
    
}

