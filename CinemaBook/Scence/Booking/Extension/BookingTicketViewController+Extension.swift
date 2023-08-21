//
//  BookingTicketViewController+Extension.swift
//  CinemaBookTests
//
//  Created by dungtien on 8/14/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import  ObjectMapper

extension BookingTicketViewController{
    func resgisterCollection(){
        let bannertableviewcell = UINib(nibName: "ItemMovieCollectionViewCell", bundle: .main)
        collectionviewcell.register(bannertableviewcell, forCellWithReuseIdentifier: "ItemMovieCollectionViewCell")
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width/2.3, height: 280)
        layout.minimumLineSpacing = 5
        collectionviewcell.collectionViewLayout = layout
        collectionviewcell.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionviewcell.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func binđDataTableCollectionView(){
        viewModel.dataArray.bind(to: collectionviewcell.rx.items(cellIdentifier: "ItemMovieCollectionViewCell", cellType: ItemMovieCollectionViewCell.self)) { (index, data, cell) in
            cell.data = data
            cell.viewModel = self.viewModel
            
            
            }.disposed(by: rxbag)
    }
    
}

// CALL API
extension BookingTicketViewController {
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
