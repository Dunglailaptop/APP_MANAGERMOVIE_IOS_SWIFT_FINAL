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

    @IBOutlet weak var collection_view_room: UICollectionView!
    @IBOutlet weak var view_choose_resettime: UIView!
    @IBOutlet weak var view_auto_interest: UIView!
    @IBOutlet weak var height_view_success: NSLayoutConstraint!
    @IBOutlet weak var view_success: UIView!
    @IBOutlet weak var lbl_number_txt: UITextField!
    @IBOutlet weak var view_no_data: UIView!
    @IBOutlet weak var lbl_number: UILabel!
    @IBOutlet weak var lbl_datetime: UILabel!
//    @IBOutlet weak var btn_dropdown: UIButton!
//    @IBOutlet weak var dropdown: DropDown!
    var datatime = ["1:00","2:00","3:00","4:00","5:00","6:00","7:00","8:00","9:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    var viewModel = ManagementInterestMoviesViewModel()
    var router = ManagementInterestMoviesRouter()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calender: FSCalendar!
    var checkroom = false
    var checkdate = false
    var checkmovie = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view_no_data.isHidden = true
        calender.scope = .week
        calender.delegate = self
        viewModel.bind(view: self, router: router)
        register()
       bindingtable()
        registercollectionroom()
        bindingcollection()
      
        // Do any additional setup after loading the view.
    }
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
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
        
        
//        dropdown.hideOptionsWhenSelect = true
//        btn_dropdown.rx.tap.subscribe(onNext: { [weak self] in
//            self!.dropdown.showList()
//           
//        }).disposed(by: rxbag)
//        
//        dropdown.didSelect{ [self](selectedText , index ,id) in
//            var cloneEmployeeInfor = viewModel.pagationDataArray.value
//            var allvalue = viewModel.allvalue.value
//            cloneEmployeeInfor.RoomLists.idroom = id
//            cloneEmployeeInfor.Rooms.nameroom = selectedText
//            allvalue.idroom = id
//            dLog(selectedText)
//            viewModel.pagationDataArray.accept(cloneEmployeeInfor)
//            viewModel.allvalue.accept(allvalue)
//            checkroom = true
//            self.getListInterest()
//        }
        
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
        var number = 0
        var data = viewModel.allvalue.value
        dLog(number)
        presentModalInputQuantityViewController(position: 1, current_quantity: Float(data.breakTime))
    }
    
}
extension ManagementInterestMoviesViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        dLog("Selected date: \(dateString)")
        
        let from_date = dateString.components(separatedBy: "-")
        let to_date = Utils.getCurrentDateStringformatMysql().components(separatedBy: "-")
    
        let from_date_in = String(format: "%@%@%@", from_date[0], from_date[1], from_date[2])
        let to_date_in = String(format: "%@%@%@", to_date[2], to_date[1], to_date[0])
        dLog(to_date_in +  "-" + from_date_in)
    
        if from_date_in < to_date_in {
            Toast.show(message:  "Ngày chọn đã chiếu", controller: self)
            view_success.isHidden = false
            height_view_success.constant = 40
            checkmovie = 1
            view_auto_interest.isUserInteractionEnabled = false
            view_choose_resettime.isUserInteractionEnabled = false
        }else {
            view_auto_interest.isUserInteractionEnabled = true
            view_choose_resettime.isUserInteractionEnabled = true
            checkmovie = 0
            height_view_success.constant = 0
            view_success.isHidden = true
        }
        dLog(calendar)
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

//collection view list room
extension ManagementInterestMoviesViewController {
    func registercollectionroom() {
        let viewcell = UINib(nibName: "ItemRoomChooseCollectionViewCell", bundle: .main)
        collection_view_room.register(viewcell, forCellWithReuseIdentifier: "ItemRoomChooseCollectionViewCell")
        setupCollection()
        collection_view_room.rx.modelSelected(Room.self).subscribe(onNext: { [self]
            element in
            dLog(element)
            var datarooom = viewModel.dataArrayRoom.value
            datarooom.enumerated().forEach{(index,value) in
                if value.idroom == element.idroom {
                    datarooom[index].isSelected = element.isSelected == ACTIVE ? DEACTIVE:ACTIVE
                  
                }else {
                    datarooom[index].isSelected = DEACTIVE
                }
            }
            var cloneEmployeeInfor = viewModel.pagationDataArray.value
            var allvalue = viewModel.allvalue.value
            cloneEmployeeInfor.RoomLists.idroom = element.idroom
            cloneEmployeeInfor.Rooms.nameroom = element.nameroom
            allvalue.idroom = element.idroom
            viewModel.pagationDataArray.accept(cloneEmployeeInfor)
            viewModel.allvalue.accept(allvalue)
            viewModel.dataArrayRoom.accept(datarooom)
            checkroom = true
            self.getListInterest()
        })
    }
    func setupCollection() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 25)
        collection_view_room.collectionViewLayout = layout
    }
    
    func bindingcollection() {
        viewModel.dataArrayRoom.bind(to: collection_view_room.rx.items(cellIdentifier: "ItemRoomChooseCollectionViewCell", cellType: ItemRoomChooseCollectionViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
