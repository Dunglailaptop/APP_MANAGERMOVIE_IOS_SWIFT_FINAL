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
            if ManageCacheObject.getCurrentUserInfo().idrole == 2 || ManageCacheObject.getCurrentUserInfo().idrole == 3 {
                switch index {
                case 0:
            
                        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ItemAccountSettingMangerTableViewCell", for: indexPath) as! ItemAccountSettingMangerTableViewCell
                    cell.viewModel = viewModel
                        cell.selectionStyle = .none
                        return cell
                  
                 
                default:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as! LogoutTableViewCell
                    cell.btn_logout.rx.tap.asDriver().drive(onNext: { [weak self]  in
                        if ManageCacheObject.getCurrentUserInfo().idrole != 3 {
                            self?.presentModalLogout()
                        }else {
                            self!.checksession()
                        }
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
        if ManageCacheObject.getCurrentUserInfo().idrole == 2 || ManageCacheObject.getCurrentUserInfo().idrole == 3 {
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
extension AccountViewController {
    func checksession() {
        viewModel.checksession().subscribe(onNext: {
            (response) in
            dLog(response.code)
            if response.code == RRHTTPStatusCode.ok.rawValue {
  
                var dataacc = self.viewModels.datacheckin.value
                dataacc.timestart = "2023-12-08T16:06:22.449Z"
                dataacc.timeend = "2023-12-08T16:06:22.449Z"
                dataacc.checksession = 1
                dataacc.idusers = ManageCacheObject.getCurrentUserInfo().idusers
                dataacc.idcinema = ManageCacheObject.getCurrentCinema().idcinema
                self.viewModels.datacheckin.accept(dataacc)
                self.presentModalDialogConfirmWorkingSessionViewController(lbl_tittle: response.message ?? "",checkins: self.viewModels.datacheckin.value)
//                self.logoutaction()
               
            } else if response.code == 300 {
                
//                self.logoutaction()
            }else if response.code == 500 {
                dLog(response.message)
                self.logoutaction()
            }
        })
    }
    
    func presentModalDialogConfirmWorkingSessionViewController(lbl_tittle:String,checkins:checkin) {
        let dialogConfirmWorkingSessionViewController = DialogshowCheckinViewController()

        dialogConfirmWorkingSessionViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogConfirmWorkingSessionViewController.lbl_info.text = lbl_tittle
        dialogConfirmWorkingSessionViewController.checkins = checkins
        dialogConfirmWorkingSessionViewController.type = 2
//        dialogConfirmWorkingSessionViewController.delegate = self
            let nav = UINavigationController(rootViewController: dialogConfirmWorkingSessionViewController)
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
