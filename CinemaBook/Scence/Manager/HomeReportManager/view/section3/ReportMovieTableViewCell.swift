//
//  ReportFoodComboTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import Charts
import RxSwift
import RxRelay
import RxCocoa
import ObjectMapper


class ReportMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var pie_chart: PieChartView!
    var btnArray:[UIButton] = []
    
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
    override func awakeFromNib() {
        super.awakeFromNib()
        btnArray = [btn_today, btn_yesterday, btn_this_weak, btn_this_month, btn_last_month, btn_three_month, btn_this_year, btn_last_year, btn_three_year, btn_all]
               changeBgBtn(btn: btn_today)
        for btn in self.btnArray{
            btn.rx.tap.asDriver().drive(onNext: { [weak self] in
                self?.changeBgBtn(btn: btn)
            })
          
        }
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
      registercollection()
        let tablecell = UINib(nibName: "ItemMovieReportTableViewCell", bundle: .main)
        tableview.register(tablecell, forCellReuseIdentifier: "ItemMovieReportTableViewCell")
        getReportMovie()
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
        
        var clonedataReport = viewModel!.data.value
        clonedataReport.date_string = ""
        clonedataReport.report_type = sender.tag
        clonedataReport.date_string = Constans.REPORT_TYPE_DICTIONARY[sender.tag] ?? ""
        viewModel!.data.accept(clonedataReport)
        dLog(sender.tag)
     
        
         getReportMovie()
    }
}

extension ReportMovieTableViewCell {
    func getReportMovie() {
        viewModel?.getReportMovie().subscribe(onNext: { [self]
            (response) in
            dLog(response)
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<ReportMovie>().mapArray(JSONObject: response.data) {
                    dLog(response.data)
                    self.viewModel?.dataMovieReport.accept(data)
                    self.view_no_daata.isHidden = (viewModel?.dataMovieReport.value.count)! > 0 ? true:false
                setUpPieChart(dataChart: data)
                    tableview.reloadData()
                    collection_view.reloadData()
                }
            }
        })
    }
}

extension ReportMovieTableViewCell {
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
extension ReportMovieTableViewCell: UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.dataMovieReport.value.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemMovieReportTableViewCell", for: indexPath) as!  ItemMovieReportTableViewCell
        cell.selectionStyle = .none
        cell.view_color.backgroundColor = colors[indexPath.row]
        cell.lbl_number.text = String(viewModel!.dataMovieReport.value[indexPath.row].stt)
        
        return cell
    }
    
}
extension ReportMovieTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func registercollection() {
        let cellcolletion = UINib(nibName: "ItemMovieReportsCollectionViewCell", bundle: .main)
        collection_view.register(cellcolletion, forCellWithReuseIdentifier: "ItemMovieReportsCollectionViewCell")
        collection_view.dataSource = self
        collection_view.delegate = self
        setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.dataMovieReport.value.count)!
    }
    
    func setupCollectionView() {
                 let layout = UICollectionViewFlowLayout()
                 layout.scrollDirection = .horizontal
                 layout.itemSize = CGSize(width: 200, height: 80)
                 layout.minimumLineSpacing = 0
                 collection_view.collectionViewLayout = layout
        collection_view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collection_view.translatesAutoresizingMaskIntoConstraints = false
             }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ItemMovieReportsCollectionViewCell", for: indexPath) as! ItemMovieReportsCollectionViewCell
    
        cell.lbl_stt.text = String(viewModel!.dataMovieReport.value[indexPath.row].stt)
        cell.lbl_name_movie.textColor = .white
        cell.lbl_name_movie.text = viewModel?.dataMovieReport.value[indexPath.row].namemovie
//        cell.contentView.backgroundColor = colors[indexPath.row]
        cell.view_all.backgroundColor = colors[indexPath.row]
        return cell
    }
}
