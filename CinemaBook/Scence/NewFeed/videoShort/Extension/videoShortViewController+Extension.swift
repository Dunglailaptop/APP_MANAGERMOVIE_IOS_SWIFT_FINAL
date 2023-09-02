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
       
        layout.itemSize = CGSize(width: 200, height: 200)
                // Set the waterfall layout to your collection view
                self.collectionView.collectionViewLayout = layout
         
    }
    
    func bindingCollectionViewCell() {
        viewModel.dataArray.bind(to: collectionView.rx.items(cellIdentifier: "ItemVideoShortCollectionViewCell", cellType: ItemVideoShortCollectionViewCell.self)) { (index,data,cell) in
          
            
            cell.btn_makeToDetailVideoShortViewController.rx.tap.asDriver().drive(onNext: {[weak self] in
                self?.viewModel.makeToDetailVideoShortViewController()
            }).disposed(by: self.rxbag)
            
        }
    }
}
//extension videoShortViewController: UICollectionViewDelegate {
//   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//       return CGSize(width: 200, height: 200) // Set the size as needed
//   }
//
//}
