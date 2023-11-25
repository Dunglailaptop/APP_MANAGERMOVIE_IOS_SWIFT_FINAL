//
//  TimeShowViewController+Extension.swift
//  CinemaBookTests
//
//  Created by dungtien on 8/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import  RxCocoa
import RxSwift
import ObjectMapper

extension TimeShowViewController {
 //call api
 func getListInterestCinema() {
    viewModel.getListCinema().subscribe(onNext: { (response) in
                 if (response.code == RRHTTPStatusCode.ok.rawValue){
                     if let movies = Mapper<ModelinterestMovie>().mapArray(JSONObject: response.data)
                     {
                       
                         self.viewModel.listCinemaWithInterest.accept(movies)
                        self.lbl_ALL_CINAME.text = String(self.viewModel.listCinemaWithInterest.value.count)
                        self.lbl_Cinema_Foryou.text = String(self.viewModel.listCinemaWithInterest.value.count)
                        self.getListInterestMovie()
                       
                             self.view_no_data.isHidden = self.viewModel.listCinemaWithInterest.value.count > 0 ? true:false
                        
                        
                      dLog(response.data)
                     }
                 }

                 }).disposed(by: rxbag)
  }
    func getListInterestMovie() {
         viewModel.getInterestMovie().subscribe(onNext: { (response) in
                   if (response.code == RRHTTPStatusCode.ok.rawValue){
                       if let movies = Mapper<InterestMovie>().mapArray(JSONObject: response.data)
                       {
                           var onlyoneListcinema = self.viewModel.cinemaWithInterest.value
                           var datalistcinema = self.viewModel.listCinemaWithInterest.value
                           
                           datalistcinema.enumerated().forEach{ (index,value) in
                           var listinterest  =  movies.filter{ $0.idcinema == value.idcinema}
                            
                              
                               datalistcinema[index].listinterest = listinterest
                           
                          
                           }
                           self.viewModel.listCinemaWithInterest.accept(datalistcinema)
                           self.viewModel.listTime.accept(movies)

                       }
                   }

                   }).disposed(by: rxbag)
    }
}

extension TimeShowViewController{
    func register() {
        let DatePickerRowView = UINib(nibName: "DatePickerRowTableViewCell", bundle: .main)
        tableView.register(DatePickerRowView, forCellReuseIdentifier: "DatePickerRowTableViewCell")
        let ListcinemaView = UINib(nibName: "ItemCinemaTableViewCell", bundle: .main)
        tableView.register(ListcinemaView, forCellReuseIdentifier: "ItemCinemaTableViewCell")
        self.tableView.estimatedRowHeight = 80
               self.tableView.rowHeight = UITableView.automaticDimension
               tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
    }
    func bindingtableviewcell() {
        viewModel.listCinemaWithInterest.bind(to: tableView.rx.items(cellIdentifier: "ItemCinemaTableViewCell", cellType:  ItemCinemaTableViewCell.self)){ (row,data,cell) in
            cell.viewModel = self.viewModel
            cell.data = data
                  
                }.disposed(by: rxbag)
                      
        }
}
    
extension TimeShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 80
 
         }
}

