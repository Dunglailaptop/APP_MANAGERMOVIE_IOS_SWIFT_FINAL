//
//  PaymentBillViewController + Extension.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 10/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import RxCocoa
import RxSwift
import JonAlert
import UserNotifications

extension PaymentBillViewController: DialogPayment {
    func callbackPayment() {
        PaymentBill()
        dismiss(animated: true)
    }
    
    func presentPopupPayment() {
       
        let DialogShowInfoMoneyViewControllers = DialogShowInfoMoneyViewController()
        
        DialogShowInfoMoneyViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
        DialogShowInfoMoneyViewControllers.Delegate = self
        DialogShowInfoMoneyViewControllers.totalbill = TotalBill
        DialogShowInfoMoneyViewControllers.point = pointget
        let nav = UINavigationController(rootViewController: DialogShowInfoMoneyViewControllers)
        // 1
        nav.modalPresentationStyle = .overCurrentContext

        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                
                // 3
                sheet.detents = [.large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4

        present(nav, animated: true, completion: nil)
    }
}

extension PaymentBillViewController: DialogNotPayment {
    func callBackDialogNotPayment() {
        dismiss(animated: true)
    }
    
    func presentPopupNotPayment(){
        let DialogNotPaymentViewControllers = DialogNotPaymentViewController()
        
        DialogNotPaymentViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
        DialogNotPaymentViewControllers.delegate = self
        
        
        
        let nav = UINavigationController(rootViewController: DialogNotPaymentViewControllers)
        // 1
        nav.modalPresentationStyle = .overCurrentContext

        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                
                // 3
                sheet.detents = [.large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4

        present(nav, animated: true, completion: nil)

        }
    
}

extension PaymentBillViewController {
    func setup() {
        var startime = infoInterestMovie.startstime.components(separatedBy: "T")
        var endtime = infoInterestMovie.endtime.components(separatedBy: "T")
        var dateshow = infoInterestMovie.dateshow.components(separatedBy: "T")
        lbl_name_movie.text = infoInterestMovie.namemovie
        lbl_time.text = String(format:"%@-%@",startime[1],endtime[1])
        lbl_dateshow.text = String(dateshow[0])
        lbl_name_room.text = infoInterestMovie.nameroom
        lbl_name_cinema.text = infoInterestMovie.namecinema
        lbl_total_amount_chair.text = Utils.stringVietnameseFormatWithNumber(amount: dataChair.map{$0.price}.reduce(0,+)) + "đ"
        lbl_total_chair_count.text = String(dataChair.count) + " ghế"
        lbl_total_combofood.text = Utils.stringVietnameseFormatWithNumber(amount: dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)) + "đ"
      dLog(infoInterestMovie)
         var namechair = ""
        dataChair.enumerated().forEach { (index, value) in
            let chairString = value.rowChar + String(value.numberChair)
            namechair += chairString + ","
        }
        lbl_chair.text = "ghế: " + String(namechair.dropLast())

        lbl_total_bill.text = Utils.stringVietnameseFormatWithNumber(amount: dataChair.map{$0.price}.reduce(0,+) + dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)) + "đ"
        lbl_total_amount_vat.text = Utils.stringVietnameseFormatWithNumber(amount: dataChair.map{$0.price}.reduce(0,+) + dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)) + "đ"
        let totalBills = dataChair.map{$0.price}.reduce(0,+) + dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)
        TotalBill = totalBills
        lbl_total_amount_final.text = Utils.stringVietnameseFormatWithNumber(amount: dataChair.map{$0.price}.reduce(0,+) + dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)) + "đ"
        viewModel.dataArrayCombo.accept(dataFoodCombo)
        image_movie.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: infoInterestMovie.poster)), placeholder: UIImage(named: "image_defauft_medium"))
        height_table.constant = CGFloat(dataFoodCombo.count * 50)
        height_combofoodadd.constant = height_table.constant + 100
        height_scroll.constant = height_combofoodadd.constant + 950
        acceptValueBill()
    }
    
    func acceptValueBill() {
        var billinfo = viewModel.databill.value
        var billVNPAY = viewModel.paymentVNPAY.value
        var paymentvnpay = viewModel.paymentVNPAY.value
        dLog(infoInterestMovie.idinterest)
        billinfo.iduser = ManageCacheObject.getCurrentUserInfo().idusers
        billinfo.quantityticket = dataChair.count
        billinfo.note = "ko co noi dung gi"
        billinfo.statusbill = 1
        billinfo.totalamount = dataChair.map{$0.price}.reduce(0,+) + dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)
        billVNPAY.amount = dataChair.map{$0.price}.reduce(0,+) + dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)
        paymentvnpay.amount = dataChair.map{$0.price}.reduce(0,+) + dataFoodCombo.map{$0.priceCombo * $0.quantity}.reduce(0,+)
        billinfo.idmovie = infoInterestMovie.idmovie
        billinfo.idcinema = infoInterestMovie.idcinema
        billinfo.idinterest = infoInterestMovie.idinterest
        dataChair.enumerated().forEach{ (index,value) in
            var dataticket = ticket()
            dataticket.idchair = value.idchair
            dataticket.idinterest = infoInterestMovie.idinterest
            billinfo.tickets.append(dataticket)
        }
        billinfo.combobills = dataFoodCombo
        viewModel.databill.accept(billinfo)
        viewModel.databillhistoryVoucher.accept(billinfo) // them vao 1 danh sach bill de luu
        viewModel.paymentVNPAY.accept(billVNPAY)
    }
    
    func getListCombo() {
           viewModel.getListFoodCombo().subscribe(onNext: {
           (response) in
               if response.code == RRHTTPStatusCode.ok.rawValue {
                   if let data = Mapper<FoodCombo>().mapArray(JSONObject: response.data) {
                       self.viewModel.dataArray.accept(data)
                   }
               }
           })
       }
    
    func PaymentBill() {
        viewModel.postCreateBill().subscribe(onNext: { [self]
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Bill>().map(JSONObject: response.data)
                {
                    
                    var paymentVNPAY = self.viewModel.paymentVNPAY.value
                    paymentVNPAY.idorder = data.idbill
                    paymentVNPAY.amount = data.totalamount
                    viewModel.paymentVNPAY.accept(paymentVNPAY)
                    JonAlert.showSuccess(message: "Thanh toan thanh cong")
                    self.viewModel.makePopToSuccessPayment()
//                    postpaymentVNPAY()
                
                    self.callPopViewController()
                }
            } else {
                JonAlert.showError(message: response.message ?? "Co loi trong qua trinh ket noi")
            }
        })
    }
    
    func postpaymentVNPAY() {
        viewModel.postpaymentVNPAY().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<PaymentVNpay>().map(JSONObject: response.data) {
                    self.viewModel.title_header.accept("THANH TOAN VNPAY")
                    self.viewModel.link_website.accept(data.urlpayment)
                    dLog(data.urlpayment)
                    self.viewModel.idbill.accept(data.idorder)
                    self.viewModel.makePolicyViewController()
                }
            }
        })
    }
    
    func getPoint()  {
      
        viewModel.getPoint().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Account>().map(JSONObject: response.data) {
                    self.pointget = data.point
                    self.getListVoucher()
                }
            }
        })
       
    }
    
    func getIdbill() {
        viewModel.getIdbillPaymentVNPAY().subscribe(onNext: { [self]
            (response) in
            dLog(response.data)
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<IdbillPaymentVNPAYRequest>().map(JSONObject: response.data) {
                    viewModel.makePopToSuccessPayment()
                    self.callPopViewController()
                
                JonAlert.showSuccess(message: response.message ?? "có lỗi xảy ra")
//                self.navigationController?.popToViewController((self.navigationController?.viewControllers[4])!, animated: true)
//                    showNotification(ID: data.idbills)
                }
              
                  
            }else {
                JonAlert.showError(message: response.message ?? "Có lỗi xảy ra")
            }
        })
    }
    
    func saveCacheBILLVNPAY() {
        viewModel.postSaveCacheVNPAYBILL().subscribe(onNext: {
            [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue
            {
                postpaymentVNPAY()
            }else
            {
                
            }
        })
    }
    
    func getListVoucher() {
        viewModel.getListVoucher().subscribe(onNext: {
            [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<voucher>().mapArray(JSONObject: response.data){
                    viewModel.dataVoucher.accept(data)
                    view_no_data_voucher.isHidden = viewModel.dataVoucher.value.count > 0 ? true:false
                    height_Table_voucher.constant = CGFloat(viewModel.dataVoucher.value.count * 60)
                    
                    height_scroll.constant = height_scroll.constant - 150 + height_Table_voucher.constant
                }
            }else {
            
            }
        })
    }
    
}
//combo
extension PaymentBillViewController {
    func registertable() {
        let tablecell = UINib(nibName: "ItemComboFoodAddTableViewCell", bundle: .main)
        tableView.register(tablecell, forCellReuseIdentifier: "ItemComboFoodAddTableViewCell")
        
        
    }
    func bindingtablecell() {
        viewModel.dataArrayCombo.bind(to: tableView.rx.items(cellIdentifier: "ItemComboFoodAddTableViewCell", cellType: ItemComboFoodAddTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
//voucher
extension PaymentBillViewController {
    func registersVOUCHER() {
        let tablecellvoucher = UINib(nibName: "ItemVoucherAddTableViewCell", bundle: .main)
        tableviewvoucher.register(tablecellvoucher, forCellReuseIdentifier: "ItemVoucherAddTableViewCell")
        tableviewvoucher.rx.modelSelected(voucher.self).subscribe(onNext: { [self]
            element in
            var datavoucher = self.viewModel.dataVoucher.value
            var databill = self.viewModel.databill.value
//            if viewModel.databillhistoryVoucher.value.idbill == 0 {
//                viewModel.databillhistoryVoucher.accept(databill)
//            }
            var datavoucherhis = viewModel.databillhistoryVoucher.value
            datavoucher.enumerated().forEach{
                (index,value) in
                
                if element.idvoucher == value.idvoucher {
                    datavoucher[index].isCheck = value.isCheck == ACTIVE ? DEACTIVE:ACTIVE
//                    self.lbl_reduce.text = String(value.price == 0 ? String(value.percent) + "%": Utils.stringVietnameseFormatWithNumber(amount: value.price) )
                    if value.price != 0 && databill.totalamount > value.price {
                        var total_final = databill.totalamount - value.price
                        var total_reduce = Utils.stringVietnameseFormatWithNumber(amount: total_final)
                        self.lbl_total_bill.text = total_reduce
                        databill.totalamount = total_final ?? 0
                        databill.idvoucher = element.idvoucher
                        self.lbl_total_amount_vat.text = total_reduce + "đ"
                        self.lbl_total_amount_final.text = total_reduce + "đ"
                        self.lbl_reduce.text = String(value.price == 0 ? String(value.percent) + "%": Utils.stringVietnameseFormatWithNumber(amount: value.price) )
                    }else
                    {
                        var percent_100 =  value.percent
                        var percent_reduce = (Double(percent_100) / 100.0) * Double(databill.totalamount)
                        var total_final = databill.totalamount - Int(percent_reduce)
                        var total_reduce_percent = Utils.stringVietnameseFormatWithNumber(amount:  total_final)
                        self.lbl_total_bill.text = total_reduce_percent
                        databill.totalamount = total_final ?? 0
                        databill.idvoucher = element.idvoucher
                        self.lbl_total_amount_vat.text = total_reduce_percent + "đ"
                        self.lbl_total_amount_final.text = total_reduce_percent + "đ"
                        self.lbl_reduce.text = String(value.price == 0 ? String(value.percent) + "%": Utils.stringVietnameseFormatWithNumber(amount: value.price) )
                    }
                    if value.isCheck == ACTIVE {
                        dLog(datavoucherhis)
                        var datatotalamount = Utils.stringVietnameseFormatWithNumber(amount: datavoucherhis.totalamount)
                        self.lbl_total_bill.text = datatotalamount
                        databill.totalamount = Int(datavoucherhis.totalamount) ?? 0
                        databill.idvoucher = element.idvoucher
                        self.lbl_total_amount_vat.text = datatotalamount
                        self.lbl_total_amount_final.text = datatotalamount
                        self.lbl_reduce.text = "0"
                    }
                    if databill.totalamount < value.price {
                        self.lbl_reduce.text = "0"
                    }
//                    if value.isCheck == ACTIVE {
//                        var datatotalamount = Utils.stringVietnameseFormatWithNumber(amount: datavoucherhis.totalamount)
//                        self.lbl_total_bill.text = datatotalamount
//                        databill.totalamount = Int(datavoucherhis.totalamount) ?? 0
//                        databill.idvoucher = element.idvoucher
//                        self.lbl_total_amount_vat.text = datatotalamount
//                        self.lbl_total_amount_final.text = datatotalamount
//                        self.lbl_reduce.text = "0"
//                    }
                 
                }else {
                    datavoucher[index].isCheck = DEACTIVE
                     
                }
                
                
                
              
            }
            self.viewModel.dataVoucher.accept(datavoucher)
            self.viewModel.databill.accept(databill)
        })
        tableviewvoucher.separatorStyle = .none
    }
    func tableviewcellVOUCHER() {
        viewModel.dataVoucher.bind(to: tableviewvoucher.rx.items(cellIdentifier: "ItemVoucherAddTableViewCell",cellType: ItemVoucherAddTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
    
}
extension PaymentBillViewController {
    func register() {
        let collectioncell = UINib(nibName: "itemComboFoodCollectionViewCell", bundle: .main)
        collectionview.register(collectioncell, forCellWithReuseIdentifier: "itemComboFoodCollectionViewCell")
//        collectionview.rx.modelSelected(FoodCombo.self).subscribe(onNext: {
//            [self] element in
//            var data = self.viewModel.dataArrayCombo.value
//            data.append(element)
//            self.viewModel.dataArrayCombo.accept(data)
//            self.tableView.reloadData()
//        })
        setupCollection()
    }
    func setupCollection() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 100)
        collectionview.collectionViewLayout = layout
    }
    
    func bindingCollectioncell() {
        viewModel.dataArray.bind(to: collectionview.rx.items(cellIdentifier: "itemComboFoodCollectionViewCell", cellType: itemComboFoodCollectionViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
extension PaymentBillViewController {
    func checkbtn() {
        btn_check_1.rx.tap.asDriver().drive(onNext: {
            self.image_check.image = UIImage(named: "check_2")
//            self.image_check_2.image = UIImage(named: "icon-check-disable")
            self.image_check_1.image = UIImage(named: "icon-check-disable")
            self.typeCheck = 1
        })
        btn_check_2.rx.tap.asDriver().drive(onNext: {
            self.image_check.image = UIImage(named: "icon-check-disable")
//            self.image_check_2.image = UIImage(named: "icon-check-disable")
            self.image_check_1.image = UIImage(named: "check_2")
            self.typeCheck  = 0
        })
//        btn_check_3.rx.tap.asDriver().drive(onNext: {
//            self.image_check.image = UIImage(named: "icon-check-disable")
//            self.image_check_2.image = UIImage(named: "check_2")
//            self.image_check_1.image = UIImage(named: "icon-check-disable")
//            self.typeCheck  = 0
//        })
    }
}
//notifiacation
extension PaymentBillViewController {
    func showNotification(ID:Int) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification(Id: ID)
            case .denied:
                dLog("Notifications denied by user")
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification(Id: ID)
                    } else {
                        if let error = error {
                            dLog("Error requesting authorization for notifications: \(error.localizedDescription)")
                        }
                    }
                }
            default:
                break
            }
        }
    }

    func dispatchNotification(Id:Int) {
        let identifier = "my_app_show"
        let title = "Thanh toán thành công"
        let body = "Xin vui lòng kiểm tra đơn hàng của bạn la: " + String(Id)
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false) // Thông báo sẽ hiển thị sau 5 giây
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request) { error in
            if let error = error {
                dLog("Error scheduling notification: \(error.localizedDescription)")
            } else {
                dLog("Notification scheduled successfully")
            }
        }
    }

}
