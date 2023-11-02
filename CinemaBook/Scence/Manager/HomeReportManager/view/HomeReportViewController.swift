//
//  HomeReportViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/10/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import ObjectMapper

class HomeReportViewController: BaseViewController {
    var viewModel = HomeReportviewModel()
    var router = HomeReportRouter()
    @IBOutlet weak var tableView: UITableView!
    weak var timer: Timer?
    @IBOutlet weak var lbl_time: UILabel!
    
    @IBOutlet weak var lbl_date: UILabel!
    
    @IBOutlet weak var view_all: UIView!
    
    @IBOutlet weak var view_all_report: UIView!
    @IBOutlet weak var lbl_tittle_all: UILabel!
    
    @IBOutlet weak var lbl_tittle_all_report: UILabel!
    var view1 = ManageReportViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgiter()
        bindingtable()
        setup()
        lbl_tittle_all.textColor = .systemBlue
        view_all.backgroundColor = ColorUtils.blueButton()
        lbl_tittle_all_report.textColor = ColorUtils.gray_600()
        view_all_report.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }
        deinit {
            timer?.invalidate()
            timer = nil
        }
    
    func setup() {
        timer?.invalidate()
               timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                   self!.lbl_time.text = Utils.getDateString().today
                   self!.lbl_date.text = Utils.getDateString().dateTimeNow
               }

    }

    @IBAction func btn_choose_all(_ sender: Any) {
        lbl_tittle_all.textColor = .systemBlue
        view_all.backgroundColor = ColorUtils.blueButton()
        lbl_tittle_all_report.textColor = ColorUtils.gray_600()
        view_all_report.backgroundColor = .clear
        view1.remove()
    }
    
    @IBAction func btn_choose_all_report(_ sender: Any) {
        lbl_tittle_all.textColor = ColorUtils.gray_600()
        view_all.backgroundColor = .clear
        lbl_tittle_all_report.textColor = .systemBlue
        view_all_report.backgroundColor = ColorUtils.blueButton()
        addTopCustomViewController(view1, addTopCustom: 60)
    }
    
}
extension HomeReportViewController: UITableViewDelegate {
    func resgiter() {
        let section1 = UINib(nibName: "ReportDetailTableViewCell", bundle: .main)
        tableView.register(section1, forCellReuseIdentifier: "ReportDetailTableViewCell")
        let section2 = UINib(nibName: "ReportTicketAllTableViewCell", bundle: .main)
        tableView.register(section2, forCellReuseIdentifier: "ReportTicketAllTableViewCell")
        let section3 = UINib(nibName: "ReportMovieTableViewCell", bundle: .main)
        tableView.register(section3, forCellReuseIdentifier: "ReportMovieTableViewCell")
        let section4 = UINib(nibName: "ReportpProductTableViewCell", bundle: .main)
        tableView.register(section4, forCellReuseIdentifier: "ReportpProductTableViewCell")
        tableView.separatorStyle = .none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
    }
    
    func bindingtable() {
        viewModel.dataArray.bind(to: tableView.rx.items) { [self] (table, index, element) -> UITableViewCell in
            let indexPath = IndexPath(row: index, section: 0)
            switch index {
            case 0:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReportDetailTableViewCell", for: indexPath) as! ReportDetailTableViewCell
                              
                           cell.selectionStyle = .none
                 
                 return cell
            case 1:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReportTicketAllTableViewCell", for: indexPath) as! ReportTicketAllTableViewCell
                cell.viewModel = self.viewModel
                           cell.selectionStyle = .none
                 
                 return cell
            case 2:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReportMovieTableViewCell", for: indexPath) as! ReportMovieTableViewCell
                cell.viewModel = self.viewModel
                           cell.selectionStyle = .none
                 
                 return cell
            case 3:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReportpProductTableViewCell", for: indexPath) as! ReportpProductTableViewCell
                cell.viewModel = self.viewModel
                           cell.selectionStyle = .none
                 
                 return cell
            default:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReportDetailTableViewCell", for: indexPath) as! ReportDetailTableViewCell
                              
                           cell.selectionStyle = .none
                 
                 return cell
            }
            
        }.disposed(by: rxbag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 450
        case 2:
            return 450
        case 3:
            return 400
        default:
            return 200
        }
    }
}
