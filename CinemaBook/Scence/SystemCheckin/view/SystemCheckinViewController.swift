//
//  SystemCheckinViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import FSCalendar
import RxSwift
import RxRelay
import RxCocoa
import ObjectMapper

class SystemCheckinViewController: UIViewController, FSCalendarDelegate {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var FCalender: FSCalendar!
    var viewModel = SystemCheckinViewModel()
    var router = SystemCheckinRouter()
    var iduer = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        FCalender.delegate = self
        FCalender.scope = .week
        register()
        bindingtableview()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var data = viewModel.pagigationcheckin.value
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formattedDate = dateFormatter.string(from: currentDate)
        data.timestart = formattedDate
        data.timeend = formattedDate
        if ManageCacheObject.getCurrentUserInfo().idrole == 3 {
            data.iduser = ManageCacheObject.getCurrentUserInfo().idusers
            data.type = 1
        }else {
            data.iduser = ManageCacheObject.getCurrentUserInfo().idusers
            data.idcinema = ManageCacheObject.getCurrentCinema().idcinema
            data.type = 2
        }
        viewModel.pagigationcheckin.accept(data)
        getlistcheckin()
    }
    

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        dLog("Ngày đã chọn được định dạng: \(formattedDate)")
        var data = viewModel.pagigationcheckin.value
        data.timeend = formattedDate
        data.timestart = formattedDate
        viewModel.pagigationcheckin.accept(data)
        getlistcheckin()
    }


}
extension SystemCheckinViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func register() {
        let system = UINib(nibName: "SystemitemCheckinTableViewCell", bundle: .main)
        tableview.register(system, forCellReuseIdentifier: "SystemitemCheckinTableViewCell")
        tableview.rx.setDelegate(self)
    }
    
    func bindingtableview() {
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "SystemitemCheckinTableViewCell",cellType: SystemitemCheckinTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
    
}
extension SystemCheckinViewController {
    func getlistcheckin() {
        viewModel.getlistcheck().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Datacheckin>().mapArray(JSONObject: response.data){
                    self.viewModel.dataArray.accept(data)
                }
            }else {
                
            }
        })
    }
}
