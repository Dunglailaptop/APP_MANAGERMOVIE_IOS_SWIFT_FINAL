//
//  HomeViewController+Extensions.swift
//  CinemaBookTests
//
//  Created by dungtien on 7/15/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import  RxCocoa
import  RxSwift


extension HomeViewController {
//    
//    static let rxbag = DisposeBag()
//    
//    func Register() {
////       let bannertableviewcell = UINib(nibName: "BannerTableViewCell", bundle: .main)
////        tableview.register(bannertableviewcell, forCellReuseIdentifier: "BannerTableViewCell")
//        let movietableviewcell = UINib(nibName: "MovieDetailTableViewCell", bundle: .main)
//        tableview.register(movietableviewcell, forCellReuseIdentifier: "MovieDetailTableViewCell")
//        
//        tableview.tableFooterView = UIView()
//    }
//    func bindingtable() {
//        viewModel.listtablecell.bind(to: tableview.rx.items(cellIdentifier: "MovieDetailTableViewCell", cellType: MovieDetailTableViewCell.self))
//        {(row, orderDetail, cell) in
//        return cell
//            }.disposed(by: HomeViewController.rxbag)
//    }
////    func bindingtable() {
////        viewModel.listtablecell.bind(to: tableview.rx.items)
////        { [self] (table, index, employee) -> UITableViewCell in
////            let indexPath = IndexPath(row: index, section: 0)
////            switch index {
////            case 0:
////                let cell = self.tableview.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as! BannerTableViewCell
////
////              cell.selectionStyle = .none
////                return cell
////            case 1:
////                let cell = self.tableview.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCell", for: indexPath) as! MovieDetailTableViewCell
////
////                cell.selectionStyle = .none
////                return cell
////            default:
////                let cell = self.tableview.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCell", for: indexPath) as! MovieDetailTableViewCell
////
////                cell.selectionStyle = .none
////                return cell
////            }
////
////
////            }.disposed(by: HomeViewController.rxbag)
////    }
//}
//extension HomeViewController:UITableViewDelegate{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        switch indexPath.row {
//        case 0:
//            return 2000
//        case 1:
//            return 2000
//        default:
//            return 2000
//        }
//
//    }
}
