//
//  OrderProductViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class OrderProductViewController: UIViewController {
    
    
    var viewModel = OrderProductViewModel()
    var router = OrderProductRouter()

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        register()
        bindCollecion()
    }


    

}


extension OrderProductViewController {
    func register() {
        let cellCollection = UINib(nibName: "ItemProductOrderCollectionViewCell", bundle: .main)
        collectionView.register(cellCollection, forCellWithReuseIdentifier: "ItemProductOrderCollectionViewCell")
        setupCollection()
    }
    
    func setupCollection() {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical // Đặt hướng cuộn là dọc
          
          let collectionViewWidth = view.frame.size.width
        let cellWidth = (collectionViewWidth - 30)/2
        dLog(collectionView.frame.size.width)
          dLog(cellWidth)
          layout.itemSize = CGSize(width: cellWidth, height: 250)
         // Add constraints here
        
        
          
          collectionView.collectionViewLayout = layout
          
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollection()
    }

    
    func bindCollecion() {
        viewModel.dataArray.bind(to: collectionView.rx.items(cellIdentifier: "ItemProductOrderCollectionViewCell", cellType: ItemProductOrderCollectionViewCell.self)) {
            (row,data,cell) in
         
        }
    }
}
