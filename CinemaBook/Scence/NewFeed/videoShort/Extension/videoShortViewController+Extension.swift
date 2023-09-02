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
import CHTCollectionViewWaterfallLayout

extension videoShortViewController {
    func register() {
        let itemvideoCollectionViewCell = UINib(nibName: "ItemVideoShortCollectionViewCell", bundle: .main)
        collectionView.register(itemvideoCollectionViewCell,forCellWithReuseIdentifier: "ItemVideoShortCollectionViewCell")
//        collectionView.rx.setDelegate(self).disposed(by: rxbag)
        setupCollectionView()
    }
    
    func setupCollectionView() {
           // Create a waterfall layout
                let layout = CHTCollectionViewWaterfallLayout()

                // Change individual layout attributes for the spacing between cells
                layout.minimumColumnSpacing = 3.0
                layout.minimumInteritemSpacing = 3.0

                // Set the waterfall layout to your collection view
                self.collectionView.collectionViewLayout = layout
          collectionView.delegate = self
    }
    
    func bindingCollectionViewCell() {
        viewModel.dataArray.bind(to: collectionView.rx.items(cellIdentifier: "ItemVideoShortCollectionViewCell", cellType: ItemVideoShortCollectionViewCell.self)) { (index,data,cell) in
            
            
        }
    }
}
extension videoShortViewController: UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        return CGSize(width: view.frame.size.width/2, height: CGFloat.random(in: 300...600))
      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountFor section: Int) -> Int {
        return 2
    }
}
