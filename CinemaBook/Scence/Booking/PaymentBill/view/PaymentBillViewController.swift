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

class PaymentBillViewController: UIViewController {
    
    
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
    

}

extension PaymentBillViewController {
    func setup() {
        var startime = infoInterestMovie.startstime.components(separatedBy: "T")
        var endtime = infoInterestMovie.endtime.components(separatedBy: "T")
        var dateshow = infoInterestMovie.dateshow.components(separatedBy: "T")
        lbl_name_movie.text = infoInterestMovie.namemovie
        lbl_time.text = String(format:"%@-%@",startime[1],endtime[1])
        lbl_dateshow.text = String(dateshow[0])
        lbl_name_room.text = infoInterestMovie.nameroom
        lbl_name_cinema.text = infoInterestMovie.namecinema
        lbl_total_amount_chair.text = Utils.stringVietnameseFormatWithNumber(amount: dataChair.map{$0.price}.reduce(0,+)) + "đ"
        lbl_total_chair_count.text = String(dataChair.count) + " ghế"
        lbl_total_combofood.text = Utils.stringVietnameseFormatWithNumber(amount: dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)) + "đ"
      dLog(infoInterestMovie)
         var namechair = ""
        dataChair.enumerated().forEach { (index, value) in
            let chairString = value.rowChar + String(value.numberChair)
            namechair += chairString + ","
        }
        lbl_chair.text = "ghế: " + String(namechair.dropLast())

        lbl_total_bill.text = Utils.stringVietnameseFormatWithNumber(amount: dataChair.map{$0.price}.reduce(0,+) + dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)) + "đ"
        lbl_total_amount_vat.text = Utils.stringVietnameseFormatWithNumber(amount: dataChair.map{$0.price}.reduce(0,+) + dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)) + "đ"
        lbl_total_amount_final.text = Utils.stringVietnameseFormatWithNumber(amount: dataChair.map{$0.price}.reduce(0,+) + dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)) + "đ"
        viewModel.dataArrayCombo.accept(dataFoodCombo)
        image_movie.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: infoInterestMovie.poster)), placeholder: UIImage(named: "image_defauft_medium"))
        height_table.constant = CGFloat(dataFoodCombo.count * 50)
        height_combofoodadd.constant = height_table.constant + 100
        height_scroll.constant = height_combofoodadd.constant + 950
    }
    
    func getListCombo() {
           viewModel.getListFoodCombo().subscribe(onNext: {
           (response) in
               if response.code == RRHTTPStatusCode.ok.rawValue {
                   if let data = Mapper<FoodCombo>().mapArray(JSONObject: response.data) {
                       self.viewModel.dataArray.accept(data)
                   }
               }
           })
       }
}
extension PaymentBillViewController {
    func registertable() {
        let tablecell = UINib(nibName: "ItemComboFoodAddTableViewCell", bundle: .main)
        tableView.register(tablecell, forCellReuseIdentifier: "ItemComboFoodAddTableViewCell")
        
    }
    func bindingtablecell() {
        viewModel.dataArrayCombo.bind(to: tableView.rx.items(cellIdentifier: "ItemComboFoodAddTableViewCell", cellType: ItemComboFoodAddTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}

extension PaymentBillViewController {
    func register() {
        let collectioncell = UINib(nibName: "itemComboFoodCollectionViewCell", bundle: .main)
        collectionview.register(collectioncell, forCellWithReuseIdentifier: "itemComboFoodCollectionViewCell")
//        collectionview.rx.modelSelected(FoodCombo.self).subscribe(onNext: {
//            [self] element in
//            var data = self.viewModel.dataArrayCombo.value
//            data.append(element)
//            self.viewModel.dataArrayCombo.accept(data)
//            self.tableView.reloadData()
//        })
        setupCollection()
    }
    func setupCollection() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 100)
        collectionview.collectionViewLayout = layout
    }
    
    func bindingCollectioncell() {
        viewModel.dataArray.bind(to: collectionview.rx.items(cellIdentifier: "itemComboFoodCollectionViewCell", cellType: itemComboFoodCollectionViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
extension PaymentBillViewController {
    func checkbtn() {
        btn_check_1.rx.tap.asDriver().drive(onNext: {
            self.image_check.image = UIImage(named: "check_2")
            self.image_check_2.image = UIImage(named: "icon-check-disable")
            self.image_check_1.image = UIImage(named: "icon-check-disable")
            
        })
        btn_check_2.rx.tap.asDriver().drive(onNext: {
            self.image_check.image = UIImage(named: "icon-check-disable")
            self.image_check_2.image = UIImage(named: "icon-check-disable")
            self.image_check_1.image = UIImage(named: "check_2")
        })
        btn_check_3.rx.tap.asDriver().drive(onNext: {
            self.image_check.image = UIImage(named: "icon-check-disable")
            self.image_check_2.image = UIImage(named: "check_2")
            self.image_check_1.image = UIImage(named: "icon-check-disable")
        })
    }
}
