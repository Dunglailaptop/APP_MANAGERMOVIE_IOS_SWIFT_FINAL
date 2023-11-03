//
//  ReportFoodViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 03/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import Charts

class ReportFoodViewController: UIViewController {

    var btnArray:[UIButton] = []
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lbl_total_billfood: UILabel!
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
    @IBOutlet weak var bar_chart: BarChartView!
    
    var viewModel = ReportFoodViewModel()
    var router = ReportFoodRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        btnArray = [btn_today, btn_yesterday, btn_this_weak, btn_this_month, btn_last_month, btn_three_month, btn_this_year, btn_last_year, btn_three_year, btn_all]
               changeBgBtn(btn: btn_today)
        for btn in self.btnArray{
            btn.rx.tap.asDriver().drive(onNext: { [weak self] in
                self?.changeBgBtn(btn: btn)
            })
          
        }
        resgiter()
        bindingtable()
        getReportfood()
        
        // Do any additional setup after loading the view.
    }

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
     
        
        getReportfood()
    }
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
}

extension ReportFoodViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func resgiter() {
        let viewcell = UINib(nibName: "ReportFoodItemCellTableViewCell", bundle: .main)
        tableview.register(viewcell, forCellReuseIdentifier:"ReportFoodItemCellTableViewCell")
        tableview.rx.setDelegate(self)
    }
    func bindingtable() {
        viewModel.datafoodReport.bind(to: tableview.rx.items(cellIdentifier: "ReportFoodItemCellTableViewCell",cellType: ReportFoodItemCellTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}

extension ReportFoodViewController {
    func getReportfood() {
        viewModel.getReportfood().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<ReportFoodTotalAll>().map(JSONObject: response.data){
                    self.viewModel.datafoodReport.accept(data.reportMovieshows)
                    self.setupBarChart(data: data.reportMovieshows, barChart: self.bar_chart)
                    self.view_no_daata.isHidden = (self.viewModel.datafoodReport.value.count) > 0 ? true: false
                    self.lbl_total_billfood.text = Utils.stringVietnameseFormatWithNumber(amount: data.totalall)
                }
            }
        })
    }
}
extension ReportFoodViewController {
    func setupBarChart(data:[ReportFood],barChart:BarChartView){
        ChartUtils.customBarChart2(
            chartView: bar_chart,
            barChartItems: data.enumerated().map{(i,value) in BarChartDataEntry(x: Double(i), y: Double(value.totals))},
            xLabel: data.map{$0.namefood}
        )
        
        bar_chart.isUserInteractionEnabled = true
        // calculate the required height for the chart based on the number of labels and their rotated height
        let labelHeight = barChart.xAxis.labelRotatedHeight // use the rotated label height
        let labelRotationAngle = CGFloat(barChart.xAxis.labelRotationAngle) * .pi / 180 // convert the rotation angle to radians
        let chartHeight = barChart.frame.origin.y + (CGFloat(barChart.xAxis.labelCount) * labelHeight * abs(cos(labelRotationAngle))) // use the rotated height and the cosine of the rotation angle
        // resize the height of the chart view
        barChart.frame.size.height = chartHeight

    }
}
