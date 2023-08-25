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
        self.scroll_view_zoom.addGestureRecognizer(pinchGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        self.scroll_view_zoom.addGestureRecognizer(panGesture)
        
      setupCollectionView(rows: 20, columns: 20,itemSize: 50)
    }
    
//    @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
//        if gesture.state == .changed {
//            let currentScale = view_collection.transform.a
//            let newScale = currentScale * gesture.scale
//
//            // Set a minimum and maximum scale to limit zooming
//            let minScale: CGFloat = 0.5
//            let maxScale: CGFloat = 3.0
//            let scaledValue = min(max(newScale, minScale), maxScale)
//
//            view_collection.transform = CGAffineTransform(scaleX: scaledValue, y: scaledValue)
//            gesture.scale = 1.0
//        }
//    }

 @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            let currentScale = view_collection.transform.a
            let newScale = currentScale * gesture.scale

            // Set a minimum and maximum scale to limit zooming
            let minScale: CGFloat = 0.5
            let maxScale: CGFloat = 3.0
            let scaledValue = min(max(newScale, minScale), maxScale)

            view_collection.transform = CGAffineTransform(scaleX: scaledValue, y: scaledValue)
            
            // Calculate the new width and height based on the scaled value
            let newWidth = originalCollectionViewSize.width * scaledValue
            let newHeight = originalCollectionViewSize.height * scaledValue
            
            // Calculate the x and y translation needed to keep it centered
            let xOffset = (originalCollectionViewSize.width - newWidth) / 2.0
            let yOffset = (originalCollectionViewSize.height - newHeight) / 2.0
            
            // Update the frame and transform of the UICollectionView
            view_collection.frame = CGRect(x: scroll_view_zoom.frame.origin.x + xOffset, y: scroll_view_zoom.frame.origin.y + yOffset, width: newWidth, height: newHeight)
            
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
    
    
      func setupCollectionView(rows: Int, columns: Int, itemSize: CGFloat) {
          let layout = UICollectionViewFlowLayout()

          layout.minimumInteritemSpacing = 5
          layout.minimumLineSpacing = 5

          layout.itemSize = CGSize(width: itemSize, height: itemSize)
          layout.sectionInset = UIEdgeInsets(top: 100, left: 20, bottom: 100, right: 20)
          layout.scrollDirection = .horizontal
     
          view_collection.collectionViewLayout = layout
          view_collection.backgroundColor = UIColor.lightGray

          // Tính toán kích thước thực tế của UICollectionView dựa trên số hàng và số cột
          let collectionViewWidth = CGFloat(columns) * itemSize + CGFloat(columns - 1) * 5
          let collectionViewHeight = CGFloat(rows) * itemSize + CGFloat(rows - 1) * 5

          // Cập nhật kích thước của UICollectionView và contentSize của scrollView
          view_collection.frame.size = CGSize(width: collectionViewWidth, height: collectionViewHeight)
        
        view_collection.backgroundColor = .clear
          scroll_view_zoom.contentSize = CGSize(width: collectionViewWidth, height: collectionViewHeight)

          // Đảm bảo scrollView có thể cuộn ngang
          scroll_view_zoom.isScrollEnabled = true
          scroll_view_zoom.showsHorizontalScrollIndicator = true
      }



     // ...
 














    
//    func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
////        layout.scrollDirection = .vertical
////        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 30, height: 30)
//        layout.minimumLineSpacing = 5
//        view_collection.collectionViewLayout = layout
//        view_collection.contentInset = UIEdgeInsets(top: 150, left: -5, bottom: 0, right: -5)
//        view_collection.translatesAutoresizingMaskIntoConstraints = false
//
//            view_collection.backgroundColor = ColorUtils.backgroudcolor()
//
//    }
    
    func binđDataTableCollectionView(){
        viewModel.dataArray.bind(to: view_collection.rx.items(cellIdentifier: "ItemChairCollectionViewCell", cellType: ItemChairCollectionViewCell.self)) { (index, element, cell) in
            
            
            
            
            }.disposed(by: BookingChairViewController.rxbag)
    }
}
