//
//  PaymentFoodComboViewController + Extensions.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 15/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import JonAlert

extension PaymentFoodComboViewController {
    func getListVoucher() {
        viewModel.getListVoucher().subscribe(onNext: {
            [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<voucher>().mapArray(JSONObject: response.data) {
                    viewModel.dataVoucher.accept(data)
                    view_no_datat.isHidden = viewModel.dataVoucher.value.count > 0 ? true:false
                    height_voucher.constant = CGFloat(viewModel.dataVoucher.value.count * 60)
                    height_scroll.constant = height_scroll.constant  + height_voucher.constant - 150
                }
            }
        })
    }
    
    func paymentBillFoodCombo() {
        viewModel.PaymentBillFoodCombo().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<PaymentFoodCombo>().map(JSONObject: response.data) {
                    dLog(data)
                    JonAlert.showSuccess(message: "Thanh toán thành công")
                    self.showNotification(idorder: data.id)
//                    var databilldelete = FoodCombo()
//                    ManageCacheObject.saveCartInfo(databilldelete)
                    self.viewModel.maKeToViewController()
                }
            }
        })
    }
}
extension PaymentFoodComboViewController {
    func showNotification(idorder:Int) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification(idordeR: idorder)
            case .denied:
                dLog("Notifications denied by user")
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification(idordeR: idorder)
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

    func dispatchNotification(idordeR:Int) {
        let identifier = "my_app_show"
        let title = "Thanh toán thành công"
        let body = "Mã đơn hàng của bạn là: " + String(idordeR)
        
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
