//
//  ReportMovieViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 03/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import Charts
import RxSwift
import RxCocoa
import RxRelay

class ReportMovieViewController: BaseViewController {

    var viewModel = ReportMovieViewModel()
    var router = ReportMovieRouter()
    @IBOutlet weak var pie_chart: PieChartView!
    var btnArray:[UIButton] = []
    
    @IBOutlet weak var tableview2: UITableView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lbl_total_bill: UILabel!
    @IBOutlet weak var btn_today: UIButton!
    
    @IBOutlet weak var view_no_daata: UIView!
    @IBOutlet weak var btn_all: UIButton!
    @IBOutlet weak var btn_three_year: UIButton!
    @IBOutlet weak var btn_last_year: UIButton!
    @IBOutlet weak var btn_this_year: UIButton!
    @IBOutlet weak var btn_three_month: UIButton!
    @IBOutlet weak var btn_last_month: UIButton!
    @IBOutlet weak var btn_this_month: UIButton!
    @IBOutlet weak var btn_this_weak: UIButton!
    @IBOutlet weak var btn_yesterday: UIButton!
    var pieChartItems = [PieChartDataEntry]()
    var colors = ColorUtils.chartColors()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgisterTable2()
        bindingtable()
        btnArray = [btn_today, btn_yesterday, btn_this_weak, btn_this_month, btn_last_month, btn_three_month, btn_this_year, btn_last_year, btn_three_year, btn_all]
               changeBgBtn(btn: btn_today)
        for btn in self.btnArray{
            btn.rx.tap.asDriver().drive(onNext: { [weak self] in
                self?.changeBgBtn(btn: btn)
            })
          
        }
        resgister()
        // Do any addresgisteritional setup after loading the view.
    }
    func resgister() {
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        let tablecell = UINib(nibName: "ItemMovieReportTableViewCell", bundle: .main)
        tableview.register(tablecell, forCellReuseIdentifier: "ItemMovieReportTableViewCell")
        getReportMovie()
    }
    

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    

}
extension ReportMovieViewController {
    func changeBgBtn(btn:UIButton){
         for button in self.btnArray{
             button.backgroundColor = ColorUtils.white()
             button.setTitleColor(ColorUtils.textLabelBlue(),for: .normal)
             button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
             button.borderWidth = 1
             button.borderColor = ColorUtils.textLabelBlue()
         }
         btn.borderWidth = 1
        btn.setTitleColor(.white, for: .normal)
         btn.backgroundColor = ColorUtils.buttonBlueColor()
        
     }
    
    @IBAction func actionChooseReportType(_ sender: UIButton) {
        
        guard  self.viewModel != nil else {return}
        
        var clonedataReport = viewModel.data.value
        clonedataReport.date_string = ""
        clonedataReport.report_type = sender.tag
        clonedataReport.date_string = Constans.REPORT_TYPE_DICTIONARY[sender.tag] ?? ""
        viewModel.data.accept(clonedataReport)
        dLog(sender.tag)
     
        
         getReportMovie()
    }
}

