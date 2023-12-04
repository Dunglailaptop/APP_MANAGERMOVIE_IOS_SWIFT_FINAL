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
    var lineChartItems = [ChartDataEntry]()
    @IBOutlet weak var lineChart: LineChartView!
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
//                    self.setupBarChart(data: data.reportMovieshows, barChart: self.bar_chart)
                    self.setupLineChart(revenues: data.reportMovieshows)
                    self.view_no_daata.isHidden = (self.viewModel.datafoodReport.value.count) > 0 ? true: false
                    self.lbl_total_billfood.text = Utils.stringVietnameseFormatWithNumber(amount: data.totalall)
                }
            }
        })
    }
}

extension ReportFoodViewController:AxisValueFormatter {
//    func setupBarChart(data:[ReportFood],barChart:BarChartView){
//        ChartUtils.customBarChart2(
//            chartView: bar_chart,
//            barChartItems: data.enumerated().map{(i,value) in BarChartDataEntry(x: Double(i), y: Double(value.totals))},
//            xLabel: data.map{$0.namefood}
//        )
//
//        bar_chart.isUserInteractionEnabled = true
//        // calculate the required height for the chart based on the number of labels and their rotated height
//        let labelHeight = barChart.xAxis.labelRotatedHeight // use the rotated label height
//        let labelRotationAngle = CGFloat(barChart.xAxis.labelRotationAngle) * .pi / 180 // convert the rotation angle to radians
//        let chartHeight = barChart.frame.origin.y + (CGFloat(barChart.xAxis.labelCount) * labelHeight * abs(cos(labelRotationAngle))) // use the rotated height and the cosine of the rotation angle
//        // resize the height of the chart view
//        barChart.frame.size.height = chartHeight
//
//    }
    func setupLineChart(revenues:[ReportFood]) {
        lineChart.noDataText = "Chưa có dữ liệu!"
        lineChart.noDataFont = UIFont(name: "Helvetica", size: 10.0)!
        lineChartItems.removeAll()
        
        let revenues = revenues
        for i in 0..<revenues.count {
            lineChartItems.append(ChartDataEntry(x: Double(i), y: Double(revenues[i].totals / 1000)))
        }
        //Line Chart
        let lineChartDataSet = LineChartDataSet(entries: lineChartItems, label: "")
        lineChartDataSet.setColor(ColorUtils.blue_color())
        lineChartDataSet.setCircleColor(ColorUtils.blue_color())
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.circleRadius = 3
        // Set the color for the filled area under the line
        lineChartDataSet.fillColor = ColorUtils.color_chartline()
        lineChartDataSet.drawFilledEnabled = true // Enable drawing the filled area under the line

        // Optionally, if you want to customize the transparency of the filled area
        lineChartDataSet.fillAlpha = 0.5 // Set the alpha (transparency) value as needed (0.0 - 1.0)

        
        lineChart.data = LineChartData(dataSet: lineChartDataSet)
        lineChart.legend.enabled = false
        lineChart.chartDescription.enabled = false
        lineChart.backgroundColor = UIColor.white
        lineChart.leftAxis.drawAxisLineEnabled = true
        lineChart.leftAxis.drawGridLinesEnabled = true
        lineChart.leftAxis.valueFormatter = self // Thêm phương thức
        lineChart.rightAxis.enabled = false
        lineChart.xAxis.drawAxisLineEnabled = false
        lineChart.xAxis.drawGridLinesEnabled = true
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.leftAxis.axisMinimum = 0
        lineChart.xAxis.axisMinimum = -1
        lineChart.xAxis.axisMaximum = Double(lineChartItems.count)
        lineChart.xAxis.labelCount = lineChartDataSet.count + 1
        lineChart.xAxis.labelFont = NSUIFont(descriptor: UIFontDescriptor(name: "System", size: 9), size: 9)
        lineChart.pinchZoomEnabled = false
        lineChart.doubleTapToZoomEnabled = false
        lineChart.xAxis.labelRotationAngle = -40
        lineChart.xAxis.labelRotatedHeight = 60
        lineChart.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: ChartEasingOption.easeInOutQuart)
        
        var x_label = [String]()
        for i in 0 ..< revenues.count {
            x_label.append(revenues[i].namefood)
        }
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: x_label)
    }
    
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        dLog(value)
        if(value >= 0 && value < 1000 ){
            return String(format: "%@ K", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
        }else if(value >= 1000 && value < 1000000 ){
            return String(format: "%@ Tr", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000))
        }else if(value >= 1000000){
            return String(format: "%@ Tỷ", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000000))
        }
        return String(format: "%@", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
     }
}
