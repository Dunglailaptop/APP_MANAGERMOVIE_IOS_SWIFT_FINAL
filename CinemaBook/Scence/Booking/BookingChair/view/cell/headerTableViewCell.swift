//
//  headerTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class headerTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var viewModel: BookingChairViewModel? = nil {
        didSet {
            registerCollectionview()
            bindingCollectionviewcell()
        }
    }
    
    
}

extension headerTableViewCell {
     func registerCollectionview() {
            let collectionviewcell = UINib(nibName: "ItemChairCategoryCollectionViewCell", bundle: .main)
            viewCollection.register(collectionviewcell, forCellWithReuseIdentifier: "ItemChairCategoryCollectionViewCell")
           setupCollectionView(itemSize: 100)
        }
        
        func setupCollectionView(itemSize: CGFloat) {
             let layout = UICollectionViewFlowLayout()

             layout.minimumInteritemSpacing = 5
             layout.minimumLineSpacing = 5

             layout.itemSize = CGSize(width: itemSize, height: itemSize) // Chỉ rộng mà không cao
             layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
             layout.scrollDirection = .horizontal
             
             viewCollection.collectionViewLayout = layout
             viewCollection.backgroundColor = ColorUtils.backgroudcolor()

             // Tính toán kích thước thực tế của UICollectionView dựa trên số hàng và số cột
             let collectionViewWidth = CGFloat(1) * itemSize + CGFloat(1 - 1) * 5
             let collectionViewHeight = itemSize  // Mỗi hàng chỉ chứa một cell, nên chiều cao là chiều cao của cell

             viewCollection.frame.size = CGSize(width: collectionViewWidth, height: collectionViewHeight)

             // Đảm bảo scrollView có thể cuộn ngang
             viewCollection.isScrollEnabled = true
         }


        func bindingCollectionviewcell() {
            viewModel!.ChairCategory.bind(to: viewCollection.rx.items(cellIdentifier: "ItemChairCategoryCollectionViewCell", cellType: ItemChairCategoryCollectionViewCell.self)) { (index, data, cell) in
                
              
               
            
            
            
            }.disposed(by: BookingChairViewController.rxbag)
        }
}
