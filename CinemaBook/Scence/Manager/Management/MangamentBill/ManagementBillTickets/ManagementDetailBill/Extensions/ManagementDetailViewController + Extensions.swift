//
//  ManagementDetailViewController + Extensions.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 26/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper

extension ManagementDetailBillViewController {
    func getDetailBill() {
        viewModel.getListDetailBill().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue
            {
                if let data = Mapper<detailBill>().map(JSONObject: response.data) {
                    self.viewModel.dataInfoBill.accept(data)
                    self.viewModel.dataArrayticket.accept(data.detailTickets)
                    self.viewModel.dataArrayfoodcombo.accept(data.detailFoodcombos)
                    self.view_no_data_combolist.isHidden = self.viewModel.dataInfoBill.value.detailFoodcombos.count > 0 ? true: false
                    self.view_no_data_listchair.isHidden = self.viewModel.dataInfoBill.value.detailTickets.count > 0 ? true: false
                    self.setup()
                }
            }
        })
    }
    func setup() {
        lbl_name_movie.text = viewModel.dataInfoBill.value.namemovie
        lbl_idBill.text = String(viewModel.dataInfoBill.value.idbill)
        var dateinterest = viewModel.dataInfoBill.value.starttime.components(separatedBy: "T")
        var dateinterestend = viewModel.dataInfoBill.value.endTime.components(separatedBy: "T")
        var interestTimeStart = dateinterest[1].components(separatedBy: ":")
        var starttime = interestTimeStart[0] + ":" + interestTimeStart[1]
        var interestTimeEnd = dateinterestend[1].components(separatedBy: ":")
        var endtime = interestTimeEnd[0] + ":" + interestTimeEnd[1]
        lbl_time_all.text = starttime + "-" + endtime
        lbl_date_interest.text = dateinterest[0]
        lbl_room.text = viewModel.dataInfoBill.value.nameroom
        var timecreatebill = viewModel.dataInfoBill.value.dateBill.components(separatedBy: "T")
        lbl_date.text = timecreatebill[0] + "-" + timecreatebill[1]
        if viewModel.dataInfoBill.value.status == 1 {
            view_status.text = "Đã thanh toán"
            view_status.backgroundColor = .green
        }else {
            view_status.text = "Đã xem phim"
            view_status.backgroundColor = .red
        }
        var totalprices = viewModel.dataInfoBill.value.detailTickets.map{$0.price}.reduce(0,+) + viewModel.dataInfoBill.value.detailFoodcombos.map{$0.totalprice}.reduce(0,+)
        lbl_total_bill.text = Utils.stringVietnameseFormatWithNumber(amount:  totalprices)
        lbl_number_ticket_total.text = String(viewModel.dataInfoBill.value.quantityticket)
        lbl_voucher.text = String(viewModel.dataInfoBill.value.namevoucher)
        image_voucher.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: viewModel.dataInfoBill.value.poster)), placeholder: UIImage(named: "image_defauft_medium"))
        
    }
    
}
extension ManagementDetailBillViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func resgister() {
        let viewcell = UINib(nibName: "ManagementItemTicketTableViewCell", bundle: .main)
        tableview.register(viewcell, forCellReuseIdentifier: "ManagementItemTicketTableViewCell")
        tableview.rx.setDelegate(self)
    }
    
    func bindingtableview() {
        viewModel.dataArrayticket.bind(to: tableview.rx.items(cellIdentifier: "ManagementItemTicketTableViewCell", cellType: ManagementItemTicketTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
    
    func resgister2() {
        let viewcell = UINib(nibName: "ItemfoodcombobillTableViewCell", bundle: .main)
        tableview2.register(viewcell, forCellReuseIdentifier: "ItemfoodcombobillTableViewCell")
        tableview2.rx.setDelegate(self)
    }
    
    func bindingtableview2() {
        viewModel.dataArrayfoodcombo.bind(to: tableview2.rx.items(cellIdentifier: "ItemfoodcombobillTableViewCell", cellType: ItemfoodcombobillTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
