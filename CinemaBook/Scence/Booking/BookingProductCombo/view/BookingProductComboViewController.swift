//
//  BookingProductComboViewController.swift
//  CinemaBook
//
//  Created by dungtien on 10/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BookingProductComboViewController: UIViewController {

    @IBOutlet weak var lbl_number_chair: UILabel!
    @IBOutlet weak var lbl_price_chair: UILabel!
    @IBOutlet weak var lbl_name_movie: UILabel!
    @IBOutlet weak var lbl_info_interest: UILabel!
    @IBOutlet weak var lbl_name_cinema: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var viewModel = BookingProductComboViewModel()
    var router = BookingProductComboRouter()
    var dataInfoMovie = InfoInterestMovie()
    var dataChair = [chair]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        register()
        bindingtablecell()
        lbl_info_interest.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListCombo()
        setup()
    }
    
    func setup() {
        var starttime = dataInfoMovie.startstime.components(separatedBy: "T")
        var endtime = dataInfoMovie.endtime.components(separatedBy: "T")
        var dateshow = dataInfoMovie.dateshow.components(separatedBy: "T")
        lbl_info_interest.text = String(format: "%@,%@,%@-%@",dataInfoMovie.nameroom,dateshow[0],starttime[1],endtime[1])
        lbl_name_movie.text = dataInfoMovie.namemovie
        lbl_name_cinema.text = dataInfoMovie.namecinema
        lbl_price_chair.text = Utils.stringVietnameseFormatWithNumber(amount: dataChair.map { $0.price }.reduce(0, +))
        lbl_number_chair.text = String(dataChair.count) + " ghế"
    }
  
    @IBAction func btn_makePopToviewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    @IBAction func btn_makeToPaymentviewcontroller(_ sender: Any) {
        var dataFoodCombo = viewModel.dataArray.value.filter{$0.quantity > 0}
        viewModel.makePopToViewPayment(dataChair: dataChair, infoInterestMovie: dataInfoMovie, datafoodcombo: dataFoodCombo)
    }
}
extension BookingProductComboViewController: UITableViewDelegate {
    func register() {
        let cellview = UINib(nibName: "ItemProductComboTableViewCell", bundle: .main)
        tableview.register(cellview, forCellReuseIdentifier: "ItemProductComboTableViewCell")
        tableview.separatorStyle = .none
        tableview.rx.setDelegate(self)
    }
    
    func bindingtablecell() {
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "ItemProductComboTableViewCell", cellType: ItemProductComboTableViewCell.self))
        { (row,data,cell) in
            cell.data = data
            cell.viewModel = self.viewModel
            cell.selectionStyle = .none
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}
