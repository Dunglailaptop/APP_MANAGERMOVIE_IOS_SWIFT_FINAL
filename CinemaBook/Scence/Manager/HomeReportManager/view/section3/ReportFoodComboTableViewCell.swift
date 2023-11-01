//
//  ReportFoodComboTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ReportFoodComboTableViewCell: UITableViewCell {

    
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
extension ReportFoodComboTableViewCell {
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
extension ReportFoodComboTableViewCell {
//    func setUpPieChart(dataChart: [MaterialReportData]) {
//        self.pie_chart.noDataText = NSLocalizedString("Chưa có dữ liệu !!", comment: "")
//        pieChartItems.removeAll()
//
//        var s = 0.0
//        for i in 0 ..< dataChart.count {
//            s += Double(dataChart[i].total_cancel)
//        }
//
//        for i in 0 ..< dataChart.count {
//            pieChartItems.append(PieChartDataEntry(value: Double(dataChart[i].total_cancel), label: Utils.stringVietnameseMoneyFormatWithNumber(amount: dataChart[i].total_cancel)))
//        }
//
//        for (index, _) in dataChart.enumerated() {
//            self.colors.append(index < colors.count ? colors[index] : UIColor(hex: "5470c6"))
//            // Assign the color to the data point in your chart
//        }
//
//        let pieChartDataSet = PieChartDataSet(entries: self.pieChartItems, label: "")
//        pieChartDataSet.colors = self.colors
//        pieChartDataSet.sliceSpace = 2
//        pieChartDataSet.selectionShift = 5
//        pieChartDataSet.xValuePosition = .insideSlice
//        pieChartDataSet.yValuePosition = .insideSlice
//        pieChartDataSet.valueTextColor = UIColor.clear
//        pieChartDataSet.valueLineWidth = 0.5
//        pieChartDataSet.valueLinePart1OffsetPercentage = 0.8
//        pieChartDataSet.valueLinePart2Length = 0.2
//        pieChartDataSet.drawValuesEnabled = false
//        pieChartDataSet.drawIconsEnabled = false
//
//
//        let noZeroFormatter = NumberFormatter()
//        noZeroFormatter.zeroSymbol = ""
//        pieChartDataSet.valueFormatter = CustomChartView()
//        ChartUtils.customPieChart(chartView: pie_chart, total: Int(s))
//        let data = PieChartData(dataSet: pieChartDataSet)
//        pie_chart.data = data
//        pie_chart.data?.isHighlightEnabled = false
//
//    }
}
