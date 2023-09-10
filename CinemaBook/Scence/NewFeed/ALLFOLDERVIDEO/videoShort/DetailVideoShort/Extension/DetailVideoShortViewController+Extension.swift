//
//  DetailVideoShortViewController+Extension.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift
import  FSPagerView


extension DetailVideoShortViewController {
    func resgister() {
        let ItemDetailVideoShortCollectionViewCell = UINib(nibName: "ItemDetailVideoShortCollectionViewCell", bundle: .main)
        collectionView.register(ItemDetailVideoShortCollectionViewCell,forCellWithReuseIdentifier: "ItemDetailVideoShortCollectionViewCell")
        setupCollection()
    }
    func bindingCollectionViewCell() {
        viewModel.dataArray.bind(to: collectionView.rx.items(cellIdentifier: "ItemDetailVideoShortCollectionViewCell", cellType: ItemDetailVideoShortCollectionViewCell.self)) { (index, data, cell) in
            
        }.disposed(by: viewModel.rxbag)
    }
    
    func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.frame = view.bounds
        collectionView.translatesAutoresizingMaskIntoConstraints = true
       collectionView.decelerationRate = .fast
    }
}

