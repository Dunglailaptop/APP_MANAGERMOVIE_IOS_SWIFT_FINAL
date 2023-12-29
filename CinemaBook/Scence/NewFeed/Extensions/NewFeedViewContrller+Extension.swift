//
//  NewFeedViewContrller+Extension.swift
//  CinemaBook
//
//  Created by dungtien on 9/10/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JonAlert
import ObjectMapper

//call api
extension NewFeedViewController {
    func getListvideo() {
        viewModel.getListTraillerShowBanner().subscribe(onNext: { (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Trailler>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                    self.viewModel.dataArraySearch.accept(data)
                }
            }else {
                JonAlert.show(message: "Có lỗi trong quá trình kết nối")
            }
            
        }).disposed(by: rxbag)
    }
}

extension NewFeedViewController {
    func resgiter() {
        let Videotableviewcell = UINib(nibName: "VideoItemShowinnewfeedTableViewCell", bundle: .main)
        tableView.register(Videotableviewcell, forCellReuseIdentifier: "VideoItemShowinnewfeedTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.rx.modelSelected(Trailler.self).subscribe(onNext: {
            (element) in
            let viewcell = VieoTraillerShowViewController()
            viewcell.traillers = element
            self.navigationController?.pushViewController(viewcell, animated: true)
        })
        tableView.rx.setDelegate(self)
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using
    }
    @objc func refresh(_ sender: AnyObject) {
          // Code to refresh table view
        viewModel.clearData()
        getListvideo()
           refreshControl.endRefreshing()
       }
    
    func bindingtableviewcell() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "VideoItemShowinnewfeedTableViewCell", cellType: VideoItemShowinnewfeedTableViewCell.self)) {  (row,data,cell) in
            cell.viewModel = self.viewModel
            cell.data = data
            cell.selectionStyle = .none
        }.disposed(by: rxbag)
    }
}
extension NewFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
