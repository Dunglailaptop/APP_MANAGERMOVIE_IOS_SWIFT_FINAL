//
//  ReportpProductTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 02/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import Charts
import RxSwift
import RxCocoa
import RxRelay
import ObjectMapper

class ReportpProductTableViewCell: UITableViewCell {
    var btnArray:[UIButton] = []
    
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
    var lineChartItems = [ChartDataEntry]()
    @IBOutlet weak var linechart: LineChartView!
    @IBOutlet weak var bar_chart: BarChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnArray = [btn_today, btn_yesterday, btn_this_weak, btn_this_month, btn_last_month, btn_three_month, btn_this_year, btn_last_year, btn_three_year, btn_all]
               changeBgBtn(btn: btn_all)
        for btn in self.btnArray{
            btn.rx.tap.asDriver().drive(onNext: { [weak self] in
                self?.changeBgBtn(btn: btn)
            })
          
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var viewModel: HomeReportviewModel? = nil {
        didSet{
            getReportfood()
        }
    }
    
    @IBAction func btn_showreportfood(_ sender: Any) {
        viewModel?.makeToReportFoodViewController()
    }
}
extension ReportpProductTableViewCell {
    func getReportfood() {
        viewModel?.getReportfood().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<ReportFoodTotalAll>().map(JSONObject: response.data){
                    self.viewModel?.datafoodReport.accept(data.reportMovieshows)
                    self.setupLineChart(revenues: data.reportMovieshows)
//                    self.setupBarChart(data: data.reportMovieshows, barChart: self.bar_chart)
                    self.view_no_daata.isHidden = (self.viewModel?.datafoodReport.value.count)! > 0 ? true: false
                    self.lbl_total_billfood.text = Utils.stringVietnameseFormatWithNumber(amount: data.totalall ?? 0) 
                }
            }
        })
    }
}

extension ReportpProductTableViewCell {
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
    
}
extension ReportpProductTableViewCell:AxisValueFormatter{
    func setupLineChart(revenues:[ReportFood]) {
        linechart.noDataText = "Chưa có dữ liệu!"
        linechart.noDataFont = UIFont(name: "Helvetica", size: 10.0)!
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

        
        linechart.data = LineChartData(dataSet: lineChartDataSet)
        linechart.legend.enabled = false
        linechart.chartDescription.enabled = false
        linechart.backgroundColor = UIColor.white
        linechart.leftAxis.drawAxisLineEnabled = true
        linechart.leftAxis.drawGridLinesEnabled = true
        linechart.leftAxis.valueFormatter = self // Thêm phương thức
        linechart.rightAxis.enabled = false
        linechart.xAxis.drawAxisLineEnabled = false
        linechart.xAxis.drawGridLinesEnabled = true
        linechart.xAxis.labelPosition = .bottom
        linechart.xAxis.drawGridLinesEnabled = false
        linechart.leftAxis.axisMinimum = 0
        linechart.xAxis.axisMinimum = -1
        linechart.xAxis.axisMaximum = Double(lineChartItems.count)
        linechart.xAxis.labelCount = lineChartDataSet.count + 1
        linechart.xAxis.labelFont = NSUIFont(descriptor: UIFontDescriptor(name: "System", size: 9), size: 9)
        linechart.pinchZoomEnabled = false
        linechart.doubleTapToZoomEnabled = false
        linechart.xAxis.labelRotationAngle = -40
        linechart.xAxis.labelRotatedHeight = 60
        linechart.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: ChartEasingOption.easeInOutQuart)
        
        var x_label = [String]()
        for i in 0 ..< revenues.count {
            x_label.append(revenues[i].namefood)
        }
        linechart.xAxis.valueFormatter = IndexAxisValueFormatter(values: x_label)
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
extension ReportpProductTableViewCell {
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
        
        var clonedataReport = viewModel!.data.value
        clonedataReport.date_string = ""
        clonedataReport.report_type = sender.tag
        clonedataReport.date_string = Constans.REPORT_TYPE_DICTIONARY[sender.tag] ?? ""
        viewModel!.data.accept(clonedataReport)
        dLog(sender.tag)
     
        
        getReportfood()
    }
}
