//
//  BookingChairViewController+Extension.swift
//  CinemaBookTests
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension BookingChairViewController {
    
    static let rxbag = DisposeBag()
    
    func resgisterCollection(){
        let bannertableviewcell = UINib(nibName: "ItemChairCollectionViewCell", bundle: .main)
        view_collection.register(bannertableviewcell, forCellWithReuseIdentifier: "ItemChairCollectionViewCell")
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        view_collection.addGestureRecognizer(pinchGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        view_collection.addGestureRecognizer(panGesture)
        
       setupCollectionView()
    }
    
    @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            let currentScale = view_collection.transform.a
            let newScale = currentScale * gesture.scale
            
            // Set a minimum and maximum scale to limit zooming
            let minScale: CGFloat = 0.5
            let maxScale: CGFloat = 3.0
            let scaledValue = min(max(newScale, minScale), maxScale)
            
            view_collection.transform = CGAffineTransform(scaleX: scaledValue, y: scaledValue)
            gesture.scale = 1.0
        }
    }


    @objc private func didPan(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            let translation = gesture.translation(in: view_collection)
            view_collection.transform = view_collection.transform.translatedBy(x: translation.x, y: translation.y)
            gesture.setTranslation(CGPoint.zero, in: view_collection)
        }
    }

    
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 20, height: 20)
        layout.minimumLineSpacing = 10
        view_collection.collectionViewLayout = layout
        view_collection.contentInset = UIEdgeInsets(top: 150, left: 10, bottom: 0, right: 10)
        view_collection.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func binđDataTableCollectionView(){
        viewModel.dataArray.bind(to: view_collection.rx.items(cellIdentifier: "ItemChairCollectionViewCell", cellType: ItemChairCollectionViewCell.self)) { (index, element, cell) in
            
            
            
            
            }.disposed(by: BookingChairViewController.rxbag)
    }
}
