//
//  ListMovieShowNowViewController+Extension.swift
//  CinemaBook
//
//  Created by dungtien on 8/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift
import ObjectMapper

extension ListMovieShowNowViewController{
    func resgisterCollection(){
        let bannertableviewcell = UINib(nibName: "itemMovieTableViewCell", bundle: .main)
        tableView.register(bannertableviewcell, forCellReuseIdentifier: "itemMovieTableViewCell")
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
    }



    func binđDataTableCollectionView(){
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "itemMovieTableViewCell", cellType: itemMovieTableViewCell.self)) { (index, data, cell) in
            cell.data = data
            cell.viewModel = self.viewModel
            cell.height_button.constant = 0

            }.disposed(by: rxbag)
    }

}

// CALL API
extension ListMovieShowNowViewController {
    func getListmovie() {
        viewModel.getListMovieShow().subscribe(onNext: { (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                if let movies = Mapper<Movie>().mapArray(JSONObject: response.data)
                {
                    self.viewModel.dataArray.accept(movies)

                }
            }

            }).disposed(by: rxbag)
    }


}

extension ListMovieShowNowViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
