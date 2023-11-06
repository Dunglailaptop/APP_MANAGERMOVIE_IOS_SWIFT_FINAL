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
import JonAlert
import ObjectMapper

// CALL API
extension HomeViewController {
    
    func setupView() {
//        view_movie_coming.backgroundColor = .white
//            lbl_movie_coming.textColor = .blue
//            view_movienow.backgroundColor = .blue
//            lbl_movie_now.textColor = .white
        var data = viewModel.pagigation.value
                data.status = 1
            viewModel.pagigation.accept(data)
        getListTraillerShowBanner()
        getListVoucherShowBanner()
        getListCinemaBanner()

        }
    
    
    func getListMovieShowBanner() {
        viewModel.getListMovieShowBanner().subscribe(onNext: { [weak self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataMap = Mapper<Movie>().mapArray(JSONObject: response.data) {
//                    self.viewModel.cleardata()
                    self?.viewModel.dataArrayMovie.accept(dataMap)
//                    self?.getListTraillerShowBanner()
                }
            }else {
                JonAlert.show(message: "Co loi xay ra trong qua trinh ket noi")
            }
            
            }).disposed(by: rxbag)
    }
    func getListTraillerShowBanner() {
        viewModel.getListTraillerShowBanner().subscribe(onNext:  { [weak self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataMap = Mapper<Trailler>().mapArray(JSONObject: response.data) {
                    self?.viewModel.cleardata()
                    self?.viewModel.dataArrayTrailler.accept(dataMap)
//                    self?.getListVoucherShowBanner()
                }
            }else {
                JonAlert.show(message: "Co loi xay ra trong qua trinh ket noi")
            }
            
            }).disposed(by: rxbag)
    }
    func getListVoucherShowBanner() {
        viewModel.getListVoucherShowBanner().subscribe(onNext: { [weak self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataMap = Mapper<voucher>().mapArray(JSONObject: response.data) {
                    self?.viewModel.cleardata()
                    self?.viewModel.dataArrayVoucher.accept(dataMap)
                }
            }else {
                JonAlert.show(message: "Co loi xay ra trong qua trinh ket noi")
            }
            
            }).disposed(by: rxbag)
    }
    func getListCinemaBanner() {
        viewModel.getListCinema().subscribe(onNext: { [weak self] (response) in
             if response.code == RRHTTPStatusCode.ok.rawValue {
                 if let dataMap = Mapper<Cinema>().mapArray(JSONObject: response.data) {
                     self?.viewModel.cleardata()
                     self?.viewModel.dataArrayProduct.accept(dataMap)
                 }
             }else {
                 JonAlert.show(message: "Co loi xay ra trong qua trinh ket noi")
             }
             
             }).disposed(by: rxbag)
     }
}


extension HomeViewController {
//    
//    static let rxbag = DisposeBag()
    
    func Register() {
        let BannerMovieTable = UINib(nibName: "BannerMovieTableViewCell", bundle: .main)
        tableView.register(BannerMovieTable, forCellReuseIdentifier: "BannerMovieTableViewCell")
        let BannerVoucherTable = UINib(nibName: "BannerVoucherTableViewCell", bundle: .main)
        tableView.register(BannerVoucherTable, forCellReuseIdentifier: "BannerVoucherTableViewCell")
        let BannerTraillerTable = UINib(nibName: "BannerTraillerVideoTableViewCell", bundle: .main)
        tableView.register(BannerTraillerTable, forCellReuseIdentifier: "BannerTraillerVideoTableViewCell")
        let BannerProductTable = UINib(nibName: "BannerProductTableViewCell", bundle: .main)
              tableView.register(BannerProductTable, forCellReuseIdentifier: "BannerProductTableViewCell")
        let CategoryFunctionMoreTableViewCellS =  UINib(nibName: "CategoryFunctionMoreTableViewCell", bundle: .main)
        tableView.register(CategoryFunctionMoreTableViewCellS, forCellReuseIdentifier: "CategoryFunctionMoreTableViewCell")
      
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
          tableView.rx.setDelegate(self).disposed(by: rxbag)
    
    }
   
    func bindingtable() {
        viewModel.listtablecell.bind(to: tableView.rx.items)
        { [self]  (tableView, index, element) -> UITableViewCell in
            let indexPath = IndexPath(row: index, section: 0)
            switch index {
            case 0:
               let cell = self.tableView.dequeueReusableCell(withIdentifier: "BannerProductTableViewCell", for: indexPath) as! BannerProductTableViewCell
                              cell.viewModel = self.viewModel
                          cell.selectionStyle = .none
                
                return cell
            case 1:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "BannerMovieTableViewCell", for: indexPath) as! BannerMovieTableViewCell
                                                           
                    cell.viewModel = self.viewModel
                               
                    cell.selectionStyle = .none
                return cell
            case 2:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "CategoryFunctionMoreTableViewCell", for: indexPath) as! CategoryFunctionMoreTableViewCell
                                                           
                cell.viewModel = self.viewModel
                               
                    cell.selectionStyle = .none
                return cell
            case 3:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "BannerTraillerVideoTableViewCell", for: indexPath) as! BannerTraillerVideoTableViewCell
                           cell.viewModel = self.viewModel
                    cell.selectionStyle = .none
                           
                           return cell
            case 4:
           let cell = self.tableView.dequeueReusableCell(withIdentifier: "BannerVoucherTableViewCell", for: indexPath) as! BannerVoucherTableViewCell
                          cell.viewModel = self.viewModel
                          cell.selectionStyle = .none
                           
                    return cell
            default:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "BannerVoucherTableViewCell", for: indexPath) as! BannerVoucherTableViewCell
                    cell.viewModel = self.viewModel
                    cell.selectionStyle = .none
                                          
                return cell
            }


            }.disposed(by: rxbag)
    }
}
extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.row {
        case 0:
            return 140
        case 1:
            return 400
        case 2:
            return 155
        case 3:
            return 205
        case 4:
            return 205
        default:
            return 205
        }

    }
}
