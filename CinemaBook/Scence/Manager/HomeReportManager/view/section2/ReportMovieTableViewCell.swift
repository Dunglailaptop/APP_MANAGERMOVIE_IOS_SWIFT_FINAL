//
//  ReportMovieTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import Charts



class ReportMovieTableViewCell: UITableViewCell {

 
    
    var btnArray:[UIButton] = []
    
    @IBOutlet weak var btn_today: UIButton!
    
    @IBOutlet weak var btn_all: UIButton!
    @IBOutlet weak var btn_three_year: UIButton!
    @IBOutlet weak var btn_last_year: UIButton!
    @IBOutlet weak var btn_this_year: UIButton!
    @IBOutlet weak var btn_three_month: UIButton!
    @IBOutlet weak var btn_last_month: UIButton!
    @IBOutlet weak var btn_this_month: UIButton!
    @IBOutlet weak var btn_this_weak: UIButton!
    @IBOutlet weak var btn_yesterday: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        btnArray = [btn_today, btn_yesterday, btn_this_weak, btn_this_month, btn_last_month, btn_three_month, btn_this_year, btn_last_year, btn_three_year, btn_all]
               changeBgBtn(btn: btn_today)
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
        didSet {
            
        }
    }
    
    
}
extension ReportMovieTableViewCell {
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
        
//        var clonedataReport = viewModel.data.value
//        clonedataReport.date_string = ""
//        clonedataReport.report_type = sender.tag
//        clonedataReport.date_string = Constants.REPORT_TYPE_DICTIONARY[sender.tag] ?? ""
//        viewModel.data.accept(clonedataReport)
//        clonedataReport.techres_saler_id = ManageCacheObject.getCurrentUser().id
//        viewModel.salerProductAdviserRequest.accept(clonedataReport)
//        // Example of posting a notification
//        nootifacationSetup(reporttype: sender.tag, datestring: Constants.REPORT_TYPE_DICTIONARY[sender.tag] ?? "")

    }
}
extension ReportMovieTableViewCell {
  
//    func setupBarChart(data:[OrderReportData],barChart:BarChartView){
//        let groupCount = data.count + 1
//        let groupSpace = 0.08 //inset padding of everygroup example |<-content->| (<-,-> is inset padding)
//        let barSpace = 0.03
//        let barWidth = 0.154
//        // (0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per "group"
//
//        barChart.chartDescription.enabled =  false
//
//        barChart.legend.horizontalAlignment = .right
//        barChart.legend.verticalAlignment = .top
//        barChart.legend.orientation = .vertical
//        barChart.legend.drawInside = true
//        barChart.legend.font = .systemFont(ofSize: 8, weight: .light)
//        barChart.legend.yOffset = 0
//        barChart.legend.xOffset = 10
//        barChart.legend.yEntrySpace = 0
//        barChart.backgroundColor = UIColor.white
//
//        barChart.xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
//        barChart.xAxis.granularity = 1
//        barChart.xAxis.centerAxisLabelsEnabled = true
//        barChart.xAxis.labelCount = data.count
//        barChart.xAxis.labelHeight = 50
//        barChart.xAxis.centerAxisLabelsEnabled = true
//        barChart.xAxis.labelPosition = .bottom
//        barChart.xAxis.axisMinimum = 0
//        barChart.fitScreen()
//        barChart.xAxis.axisMaximum = Double(data.count)
//        let visibleXRange = 3 // Number of values to show in y-Axis
//        barChart.setVisibleXRangeMaximum(Double(visibleXRange))
//        barChart.xAxis.setLabelCount(visibleXRange, force: false)
//        barChart.xAxis.granularity = 1
//        barChart.xAxis.labelCount = visibleXRange
//        barChart.dragEnabled = true
//
//
//        barChart.leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
//        barChart.leftAxis.valueFormatter = self
//        barChart.leftAxis.spaceTop = 0.35
//        barChart.leftAxis.axisMinimum = 0
//        barChart.rightAxis.enabled = false
//
//
//        //======================================
//        var v1: [BarChartDataEntry] = []
//        var v2: [BarChartDataEntry] = []
//        var v3: [BarChartDataEntry] = []
//        var v4: [BarChartDataEntry] = []
//        var v5: [BarChartDataEntry] = []
//
//
//        var x_label:[String] = []
//
//        for i in 0..<data.count {
//
//            dLog(data[0].total_amount)
//
//            x_label.append(ChartUtils.getXLabel(dateTime: data[i].report_time, reportType: viewModel.report_type.value, dataPointnth:i))
//
//            let entry = BarChartDataEntry(x: Double(i), y: Double(data[i].total_amount / 1000))
//            v1.append(entry)
//
//            // Assuming these properties are available in OrderReportData
//            let entry2 = BarChartDataEntry(x: Double(i), y: Double(data[i].order_delivered_amount/1000))
//            v2.append(entry2)
//
//            let entry3 = BarChartDataEntry(x: Double(i), y: Double(data[i].order_not_delivered_amount/1000))
//            v3.append(entry3)
//
//            let entry4 = BarChartDataEntry(x: Double(i), y: Double(data[i].order_cancel_amount/1000))
//            v4.append(entry4)
//
//            let entry5 = BarChartDataEntry(x: Double(i), y: Double(data[i].total_return_amount/1000))
//            v5.append(entry5)
//
//
//
//        }
////        let importDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
////            return BarChartDataEntry(x: Double(i), y: Double(data[i].total_amount/1000))
////        }
////
////        let exportDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
////            return BarChartDataEntry(x: Double(i), y: Double(data[i].order_delivered_amount/1000))
////        }
////
////        let returnDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
////            return BarChartDataEntry(x: Double(i), y: Double(data[i].order_not_delivered_amount/1000))
////        }
////
////        let cancelDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
////            return BarChartDataEntry(x: Double(i), y: Double(data[i].order_cancel_amount/1000))
////        }
////
////        let remainingDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
////            return BarChartDataEntry(x: Double(i), y: Double(data[i].total_return_amount/1000))
////        }
////
////        let importDataEntryArray = (0..<data.count).map(importDataEntry)
////        let exportDataEntryArray = (0..<data.count).map(exportDataEntry)
////        let returnDataEntryArray = (0..<data.count).map(returnDataEntry)
////        let cancelDataEntryArray = (0..<data.count).map(cancelDataEntry)
////        let remainingDataEntryArray = (0..<data.count).map(remainingDataEntry)
//
//
//        let importDataSet = BarChartDataSet(entries: v1, label: "Huỷ hàng")
//        importDataSet.setColor(ColorUtils.blue_first())
//
//        let exportDataSet = BarChartDataSet(entries: v2, label: "Đã giao")
//        exportDataSet.setColor(ColorUtils.green_export())
//
//        let returnDataSet = BarChartDataSet(entries: v3, label: "Chưa giao")
//        returnDataSet.setColor(ColorUtils.orange_now())
//
//        let cancelDataSet = BarChartDataSet(entries: v4, label: "HUỷ hàng")
//        cancelDataSet.setColor(ColorUtils.red_color())
//
//        let remainingDataSet = BarChartDataSet(entries: v5, label: "Trả hàng")
//        remainingDataSet.setColor(ColorUtils.water_import())
//
//
//        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:x_label)
//        let chartData: BarChartData =  [importDataSet,exportDataSet,returnDataSet,cancelDataSet,remainingDataSet]
//
//
//
//        // specify the width each bar should have
//        chartData.barWidth = barWidth
//        chartData.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
//        barChart.data = chartData
//
//        for set in barChart.data! {
//            set.drawValuesEnabled = !set.drawValuesEnabled
//        }
//
//        //chart animation
//        barChart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
//    }
//
//
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        if(value >= 0 && value < 1000 ){
//            return String(format: "%@ K", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
//        }else if(value >= 1000 && value < 1000000 ){
//            return String(format: "%@ Tr", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000))
//        }else if(value >= 1000000){
//            return String(format: "%@ Tỷ", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000000))
//        }
//        return String(format: "%@", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
//     }

}
