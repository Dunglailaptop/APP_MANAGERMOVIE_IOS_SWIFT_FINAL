//
//  ManagementInterestMovieViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/15/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import SpreadsheetView

class ManagementInterestMovieViewController: UIViewController {
    
//    var rxbag = DisposedBag()
   weak var delegate: SpreadsheetViewDelegate?
    @IBOutlet weak var lbl_dateTo: UILabel!
    @IBOutlet weak var lbl_datefrom: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    var day = ["","Thứ 2","Thứ 3","Thứ 4","Thứ 5","Thứ 6","Thứ 7","Chủ Nhật"]
    var dataTime = ["08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","24:00"]
    
    @IBOutlet weak var view_of_spreadsheet: UIView!
    public var spreadsheetview = SpreadsheetView()
    var viewModel =  ManagementInterestMovieViewModel()
    var router = ManagementInterestMovieRouter()
    var ischeckday = 0
    
    @IBOutlet weak var btn_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgister()
        bindingCollectionviewcell()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var data = viewModel.allvalue.value
        var datas = viewModel.pagationDataArray.value
        data.idcinema = ManageCacheObject.getCurrentCinema().idcinema
        datas.RoomLists.idcinema = ManageCacheObject.getCurrentCinema().idcinema
        viewModel.allvalue.accept(data)
        viewModel.pagationDataArray.accept(datas)
        self.getListRoom()
    }
    
   
    
    @IBAction func btn_save_data(_ sender: Any) {
        CreateInterest()
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
    
    
    @IBAction func btn_showDialogPopUpListViewController(_ sender: Any) {
        self.presentDialogPopUpList()
    }
    
    
}
// set view lanspace
extension ManagementInterestMovieViewController {
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
}
