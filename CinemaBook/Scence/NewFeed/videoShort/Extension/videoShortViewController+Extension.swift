//
//  videoShortViewController+Extension.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SquareFlowLayout

extension videoShortViewController {
    func register() {
        let itemvideoCollectionViewCell = UINib(nibName: "ItemVideoShortCollectionViewCell", bundle: .main)
        collectionView.register(itemvideoCollectionViewCell,forCellWithReuseIdentifier: "ItemVideoShortCollectionViewCell")
//        collectionView.rx.setDelegate(self).disposed(by: rxbag)
        setupCollectionView()
    }
    
    func setupCollectionView() {
           // Create a waterfall layout
                let layout = SquareFlowLayout()
       
            
                // Set the waterfall layout to your collection view
                self.collectionView.collectionViewLayout = layout
         
    }
    
    func bindingCollectionViewCell() {
        viewModel.dataArray.bind(to: collectionView.rx.items(cellIdentifier: "ItemVideoShortCollectionViewCell", cellType: ItemVideoShortCollectionViewCell.self)) { (index,data,cell) in
            
            
        }
    }
}
