//
//  ManagementInterestMovieViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/15/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import SpreadsheetView

class ManagementInterestMovieViewController: BaseViewController {
    
//    var rxbag = DisposedBag()

    @IBOutlet weak var lbl_dateTo: UILabel!
    @IBOutlet weak var lbl_datefrom: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    var day = ["","Thứ 2","Thứ 3","Thứ 4","Thứ 5","Thứ 6","Thứ 7","Chủ Nhật"]
    var dataTime = ["1:00","2:00","3:00","4:00","5:00","6:00","7:00","8:00","9:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","24:00"]
    
    @IBOutlet weak var view_of_spreadsheet: UIView!
    private var spreadsheetview = SpreadsheetView()
    var viewModel =  ManagementInterestMovieViewModel()
    var router = ManagementInterestMovieRouter()
    var ischeckday = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgister()
        bindingCollectionviewcell()
        spreadsheetview.register(myLabel.self, forCellWithReuseIdentifier: myLabel.identifier)
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
          UIViewController.attemptRotationToDeviceOrientation()
        spreadsheetview.dataSource = self
        spreadsheetview.frame = CGRect(x: 0, y: 0, width: view_of_spreadsheet.frame.size.width, height: view_of_spreadsheet.frame.size.height)
        view_of_spreadsheet.addSubview(spreadsheetview)
      let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            let startDate = dateFormatter.date(from: "2023-09-20")!
            let endDate = dateFormatter.date(from: "2023-09-30")!
           
            var listOfDates = Utils().getListOfDates(startDate: startDate, endDate: endDate)
            viewModel.dataArrayday.accept(listOfDates)
        
        viewModel.dataArrayday.subscribe(onNext: {
            [self] respone in
            self.spreadsheetview.reloadData()
            
            }).disposed(by: rxbag)
    }
    

    
    
    
    
    // Cho phép xoay cả hai hướng
      override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
          return .landscape
      }


       override var shouldAutorotate: Bool {
           return true
       }

       override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
           return .landscapeRight
       }

    @IBAction func btn_makeToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
   

    @IBAction func btn_choose_to(_ sender: Any) {
        ischeckday = 1
        self.showDateTimePicker(dateTimeData: Utils.getCurrentDateString())
    }
    @IBAction func btn_choose_datefrom(_ sender: Any) {
        ischeckday = 0
         self.showDateTimePicker(dateTimeData: Utils.getCurrentDateString())
    }
}
extension ManagementInterestMovieViewController: SpreadsheetViewDataSource {
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: myLabel.identifier, for: indexPath) as! myLabel
      
     if indexPath.section == 0 && indexPath.row == 0 {
             // This is the top-left cell, set it to empty or something else if needed
             cell.setup(text: "")
             cell.backgroundColor = .white
         } else if indexPath.section == 0 {
    let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd"
     
        
        let dateAsString = dateFormatter.string(from: viewModel.dataArrayday.value[indexPath.row])
      let dayOfWeek = Utils().getDayOfWeek(today: dateAsString) ?? 0 // Provide a default value if nil
        let dateOfWeekString = String(dayOfWeek)
        cell.setup(text: "thứ " + dateOfWeekString + " " + dateAsString)
        
    
        
     
          
   

             cell.backgroundColor = ColorUtils.gray_200()
         } else if indexPath.row == 0 {
             // Display times in the first column
             cell.setup(text: dataTime[indexPath.section - 1])
             cell.backgroundColor = ColorUtils.gray_200()
         } else {
             // Display other content for the rest of the cells
        cell.setup(text: dataTime[indexPath.row - 1])
             cell.backgroundColor = .white
         }

         return cell
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return viewModel.dataArrayday.value.count
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return dataTime.count
    }
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 100
    }
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 48
    }
}
class myLabel: Cell {
    
    static let identifier = "Mylabel"
    
    private let label = UILabel()
    
    public var date = ""
    
    public func setup(text:String) {
        label.text = text + date
        label.textAlignment = .center
        label.numberOfLines = 0
        contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
}
