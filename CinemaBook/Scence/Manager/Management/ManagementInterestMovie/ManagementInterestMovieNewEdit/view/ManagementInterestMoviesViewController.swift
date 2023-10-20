//
//  ManagementInterestMoviesViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 17/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import FSCalendar
import RxCocoa
import RxSwift
import RxRelay
import ObjectMapper
import iOSDropDown
import JonAlert

class ManagementInterestMoviesViewController: BaseViewController {

   
    @IBOutlet weak var lbl_number_txt: UITextField!
    @IBOutlet weak var view_no_data: UIView!
    @IBOutlet weak var lbl_number: UILabel!
    @IBOutlet weak var lbl_datetime: UILabel!
    @IBOutlet weak var btn_dropdown: UIButton!
    @IBOutlet weak var dropdown: DropDown!
    var datatime = ["1:00","2:00","3:00","4:00","5:00","6:00","7:00","8:00","9:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    var viewModel = ManagementInterestMoviesViewModel()
    var router = ManagementInterestMoviesRouter()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calender: FSCalendar!
    var checkroom = false
    var checkdate = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view_no_data.isHidden = true
        calender.scope = .week
        calender.delegate = self
        viewModel.bind(view: self, router: router)
        register()
       bindingtable()
        
      
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var dataDays = viewModel.dataDay.value
        dataDays.dateStart = Utils.getCurrentDateStringformatMysql()
        dataDays.dateEnd = Utils.getCurrentDateStringformatMysql()
        viewModel.dataDay.accept(dataDays)
        lbl_datetime.text = Utils.getCurrentDateStringformatMysql()
        getListRoom()
        getListAutoInterest()
         setup()
    }
    func setup() {
        
        
        dropdown.hideOptionsWhenSelect = true
        btn_dropdown.rx.tap.subscribe(onNext: { [weak self] in
            self!.dropdown.showList()
           
        }).disposed(by: rxbag)
        
        dropdown.didSelect{ [self](selectedText , index ,id) in
            var cloneEmployeeInfor = viewModel.pagationDataArray.value
            var allvalue = viewModel.allvalue.value
            cloneEmployeeInfor.RoomLists.idroom = id
            cloneEmployeeInfor.Rooms.nameroom = selectedText
            allvalue.idroom = id
            dLog(selectedText)
            viewModel.pagationDataArray.accept(cloneEmployeeInfor)
            viewModel.allvalue.accept(allvalue)
            checkroom = true
            self.getListInterest()
        }
        
    }

    @IBAction func btn_makechoospresentdlialog(_ sender: Any) {
        if checkdate && checkroom  {
            if viewModel.movielist.value.count == 0 {
                var dataDay = viewModel.dataDay.value
                dLog(dataDay.dateStart)
                self.presentDialogPopUpList(date: dataDay.dateStart)
            }else {
                JonAlert.showError(message: "Ngày chiếu tại phòng này đã được xếp lịch !!!!")
            }
          
        } else
        {
            JonAlert.showError(message: "Vui lòng chọn thông tin phòng chiếu ngày chiếu để thực hiện xếp lịch")
        }
     
    }
    
    @IBAction func btn_makechoosInputQuantity(_ sender: Any) {
        var number = lbl_number.text?.components(separatedBy: " ")
        
        presentModalInputQuantityViewController(position: 1, current_quantity: Float(number![0])!)
    }
    
}
extension ManagementInterestMoviesViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        dLog("Selected date: \(dateString)")
        var dataDateGet = viewModel.dataDay.value
        var allvalue = viewModel.allvalue.value
        dataDateGet.dateStart = dateString
        dataDateGet.dateEnd = dateString
        allvalue.idroom = viewModel.pagationDataArray.value.RoomLists.idroom
        allvalue.idcinema = ManageCacheObject.getCurrentCinema().idcinema
        viewModel.allvalue.accept(allvalue)
        viewModel.dataDay.accept(dataDateGet)
        checkdate = true
        getListInterest()
        lbl_datetime.text = dateString
//        self.lbl_number.text = String(self.viewModel.movielist.value.count)
//        self.getListAutoInterest()
       
       
    }
    
   
    
}
