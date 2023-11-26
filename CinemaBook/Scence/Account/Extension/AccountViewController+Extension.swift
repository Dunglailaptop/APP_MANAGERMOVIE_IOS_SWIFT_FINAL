//
//  AccountViewController+Extension.swift
//  CinemaBookTests
//
//  Created by dungtien on 8/31/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift
import FirebaseAuth

extension AccountViewController {
    func register() {
        let SettingforAccountCustomerTableViewCell = UINib(nibName: "SettingforAccountCustomerTableViewCell", bundle: .main)
        tableView.register(SettingforAccountCustomerTableViewCell, forCellReuseIdentifier: "SettingforAccountCustomerTableViewCell")
        let LogoutTableViewCell = UINib(nibName: "LogoutTableViewCell", bundle: .main)
               tableView.register(LogoutTableViewCell, forCellReuseIdentifier: "LogoutTableViewCell")
        let settingManger = UINib(nibName: "ItemAccountSettingMangerTableViewCell", bundle: .main)
        tableView.register(settingManger, forCellReuseIdentifier: "ItemAccountSettingMangerTableViewCell")
        self.tableView.estimatedRowHeight = 80
             self.tableView.rowHeight = UITableView.automaticDimension
             tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        
    }
    func bindingtableview() {
        viewModel.dataArray.bind(to: tableView.rx.items) {
            [self] (table, index, data) -> UITableViewCell in
            let indexPath = IndexPath(row: index, section: 0)
            if ManageCacheObject.getCurrentUserInfo().idrole == 2 {
                switch index {
                case 0:
            
                        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ItemAccountSettingMangerTableViewCell", for: indexPath) as! ItemAccountSettingMangerTableViewCell
                        
                        cell.selectionStyle = .none
                        return cell
                  
                 
                default:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as! LogoutTableViewCell
                    cell.btn_logout.rx.tap.asDriver().drive(onNext: { [weak self]  in
                        self?.presentModalLogout()
                    }).disposed(by: self.rxbag)
                    return cell
            }
             
            }
                else
            {
                    switch index {
                    case 0:
                        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SettingforAccountCustomerTableViewCell", for: indexPath) as! SettingforAccountCustomerTableViewCell
                        cell.viewModel = self.viewModel
                        return cell
                    case 1:
                        let cell = self.tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as! LogoutTableViewCell
                        cell.btn_logout.rx.tap.asDriver().drive(onNext: { [weak self]  in
                            self?.presentModalLogout()
                        }).disposed(by: self.rxbag)
                        cell.selectionStyle = .none
                        return cell
                    case 2:
                        
                        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ItemAccountSettingMangerTableViewCell", for: indexPath) as! ItemAccountSettingMangerTableViewCell
                        
                        cell.selectionStyle = .none
                        return cell
                        
                        
                    default:
                        let cell = self.tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as! LogoutTableViewCell
                        return cell
                    }
          
            }
        }.disposed(by: rxbag)
    }
}
extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ManageCacheObject.getCurrentUserInfo().idrole == 2 {
            switch indexPath.row {
            case 0:
                return 100
            default:
                return 60
            }
         
        }else {
            switch indexPath.row {
            case 0:
                return 200
            case 1:
                return 60
            default:
                return 0
            }
        }
     
    }
}
extension AccountViewController: LogoutConfirm {
    func callbackAccessConfirm() {
        do {
            dLog("dang suat thanh cong")
          try  FirebaseAuth.Auth.auth().signOut()
        } catch {
            dLog("Co loi xay rar")
        }
        self.logout()
        
    }
    
    func presentModalLogout() {
        let logoutview = DialogViewController()
        logoutview.type = 1
        logoutview.tittle = "Bạn có muốn đăng suất?"
        logoutview.delegate = self
        logoutview.view.backgroundColor = ColorUtils.blackTransparent()
        //Set up navigationBar
        let nav = UINavigationController(rootViewController: logoutview)
            nav.isNavigationBarHidden = true
            nav.modalPresentationStyle = .overCurrentContext
              present(nav, animated: true, completion: nil)

          }
}
