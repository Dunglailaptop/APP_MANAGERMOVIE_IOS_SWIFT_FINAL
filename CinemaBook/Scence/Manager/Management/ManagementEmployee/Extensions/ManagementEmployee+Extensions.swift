//
//  ManagementEmployee+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 9/11/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
import JonAlert

extension ManagementEmployeeViewController {
    func getlistEmployee() {
        viewModel.getListEmployee().subscribe(onNext: { (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Users>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                }
            }
            
            }).disposed(by: rxbag)
    }
    func getlockEmployee() {
           viewModel.getLockEmployee().subscribe(onNext: { (response) in
               if response.code == RRHTTPStatusCode.ok.rawValue {
                
                JonAlert.show(message: "kHOÁ TÀI KHOẢN THÀNH CÔNG")
               }else {
                JonAlert.show(message: "CÓ LỖI XẢY RA")
            }
               
               }).disposed(by: rxbag)
       }
    
    func resetPaasword() {
           viewModel.resetPassword().subscribe(onNext: { (response) in
               if response.code == RRHTTPStatusCode.ok.rawValue {
                   if let data = Mapper<Account>().map(JSONObject: response.data) {
                       self.viewModel.dataAccount.accept(data)
                       JonAlert.showSuccess(message: "Câp nhật thành công tài khoản:" + data.username)
                   }
                }else {
                    JonAlert.show(message: response.message ?? "CÓ LỖI XẢY RA")
                }
               
               
               }).disposed(by: rxbag)
       }
    
}
extension ManagementEmployeeViewController {
    func register() {
        let viewEmployeetableviewcell = UINib(nibName: "ItemEmployeeTableViewCell", bundle: .main)
        tableView.register(viewEmployeetableviewcell,forCellReuseIdentifier:"ItemEmployeeTableViewCell")
        tableView.separatorStyle = .none
        tableView.rx.setDelegate(self)
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using
    }
    @objc func refresh(_ sender: AnyObject) {
          // Code to refresh table view
           viewModel.cleardata()
            getlistEmployee()
           refreshControl.endRefreshing()
       }
    
    func bindingtablecell() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ItemEmployeeTableViewCell", cellType: ItemEmployeeTableViewCell.self)) {
            (row,data,cell) in
            
            cell.btn_lockAccount.rx.tap.asDriver().drive(onNext: { [self] in
                dLog(data.idusers)
                self.presentModalDialogAccess(idemployee: data.idusers,status:1)
            })
            cell.btn_unlock.rx.tap.asDriver().drive(onNext: { [self] in
                          dLog(data.idusers)
                          self.presentModalDialogAccess(idemployee: data.idusers,status:0)
                      })
            cell.btn_resetpassword.rx.tap.asDriver().drive(onNext: { [self] in
                var iduers = viewModel.pagation.value
                iduers.iduser = data.idusers
                viewModel.pagation.accept(iduers)
                self.resetPaasword()
            })
            
            cell.selectionStyle = .none
            cell.viewModel = self.viewModel
            cell.data = data
        }
    }
}
extension ManagementEmployeeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
}

extension ManagementEmployeeViewController: DialogAccessEmployee{
    func callbackDialogAccess(id: Int,status:Int) {
        var data = viewModel.pagation.value
        data.iduser = id
        data.status = status
        viewModel.pagation.accept(data)
        getlockEmployee()
        getlistEmployee()
//        viewModel.cleardata()
//        getlistEmployee()
        dismiss(animated: true)
        
     
    }
    
    func presentModalDialogAccess(idemployee:Int,status:Int) {
        let DialogAccessViewController = DialogViewController()
        DialogAccessViewController.delegate2 = self
        DialogAccessViewController.type = 0
        DialogAccessViewController.status = status
        DialogAccessViewController.idemployee = idemployee
        DialogAccessViewController.tittle = "Bạn có muốn khoá tài khoản nhân viên này không?"
    DialogAccessViewController.view.backgroundColor = ColorUtils.blackTransparent()

                  let nav = UINavigationController(rootViewController: DialogAccessViewController)
                  // 1
                  nav.modalPresentationStyle = .overCurrentContext

//    ////
//                  // 2
//                  if #available(iOS 15.0, *) {
//                    if let sheet = nav.presentationController as! UISheetPresentationController {
//
//                          // 3
//                          sheet.detents = [.large()]
//
//                      }
//                  } else {
//                      // Fallback on earlier versions
//                  }
//                  // 4
    ////
                  present(nav, animated: true, completion: nil)

              }
}
