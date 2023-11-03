//
//  ReportMovieViewController + Extension.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 03/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import ObjectMapper
import Charts

extension ReportMovieViewController {
    
 
    
    func resgisterTable2(){
        let viewcell = UINib(nibName: "ItemMovieReportMovieTableViewCell", bundle: .main)
        tableview2.register(viewcell, forCellReuseIdentifier: "ItemMovieReportMovieTableViewCell")
        tableview2.rx.setDelegate(self)
    }
    
    func bindingtable() {
        viewModel.dataMovieReport.bind(to: tableview2.rx.items(cellIdentifier: "ItemMovieReportMovieTableViewCell",cellType: ItemMovieReportMovieTableViewCell.self)) { [self]
            (row,data,cell) in
            cell.view_color.backgroundColor = colors[row]
            cell.lbl_movie.text = data.namemovie
            cell.image_movie.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
        }
    }
    
}

extension ReportMovieViewController {
    func getReportMovie() {
        viewModel.getReportMovie().subscribe(onNext: { [self]
            (response) in
            dLog(response)
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<ReportMovieTotalAll>().map(JSONObject: response.data) {
                    dLog(response.data)
                    self.viewModel.dataMovieReport.accept(data.reportMovieshows)
                    self.view_no_daata.isHidden = (viewModel.dataMovieReport.value.count) > 0 ? true:false
                    setUpPieChart(dataChart: data.reportMovieshows)
                    lbl_total_bill.text = Utils.stringVietnameseFormatWithNumber(amount: data.totalall)
                    tableview.reloadData()
                  
                }
            }
        })
    }
}

extension ReportMovieViewController {
    func setUpPieChart(dataChart: [ReportMovie]) {
        self.pie_chart.noDataText = NSLocalizedString("Chưa có dữ liệu !!", comment: "")
        pieChartItems.removeAll()

        var s = 0.0
        for i in 0 ..< dataChart.count {
            s += Double(dataChart[i].totals)
        }

        for i in 0 ..< dataChart.count {
            pieChartItems.append(PieChartDataEntry(value: Double(dataChart[i].totals), label:  Utils.stringVietnameseMoneyFormatWithNumber(amount: dataChart[i].totals)))
        }

        for (index, _) in dataChart.enumerated() {
            self.colors.append(index < colors.count ? colors[index] : UIColor(hex: "5470c6"))
            // Assign the color to the data point in your chart
        }

        let pieChartDataSet = PieChartDataSet(entries: self.pieChartItems, label: "")
        pieChartDataSet.colors = self.colors
        pieChartDataSet.sliceSpace = 2
        pieChartDataSet.selectionShift = 5
        pieChartDataSet.xValuePosition = .insideSlice
        pieChartDataSet.yValuePosition = .insideSlice
        pieChartDataSet.valueTextColor = UIColor.BLACK_COLOR_ALPHA()
        pieChartDataSet.valueLineWidth = 0.5
        pieChartDataSet.valueLinePart1OffsetPercentage = 0.8
        pieChartDataSet.valueLinePart2Length = 0.2
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.drawIconsEnabled = false


        let noZeroFormatter = NumberFormatter()
        noZeroFormatter.zeroSymbol = ""
        pieChartDataSet.valueFormatter = CustomChartView()
        ChartUtils.customPieChart(chartView: pie_chart, total: Int(s))
        let data = PieChartData(dataSet: pieChartDataSet)
        pie_chart.data = data
        pie_chart.data?.isHighlightEnabled = false

    }
}
extension ReportMovieViewController: UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.dataMovieReport.value.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemMovieReportTableViewCell", for: indexPath) as!  ItemMovieReportTableViewCell
        cell.selectionStyle = .none
        cell.view_color.backgroundColor = colors[indexPath.row]
        cell.lbl_number.text = String(viewModel.dataMovieReport.value[indexPath.row].stt)
        
        return cell
    }
    
}

