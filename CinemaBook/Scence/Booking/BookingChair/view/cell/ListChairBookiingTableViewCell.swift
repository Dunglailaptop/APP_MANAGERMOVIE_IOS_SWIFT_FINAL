//
//  ListChairBookiingTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ListChairBookiingTableViewCell: UITableViewCell {

    
    
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
extension ListChairBookiingTableViewCell {
    func registerCollectionview() {
        let collectionviewcell = UINib(nibName: "ItemChairCollectionViewCell", bundle: .main)
        viewCollection.register(collectionviewcell, forCellWithReuseIdentifier: "ItemChairCollectionViewCell")
        setupCollectionView(rows: 10, columns: 10, itemSize: 50)
    }
    
    func setupCollectionView(rows: Int, columns: Int, itemSize: CGFloat) {
            let layout = UICollectionViewFlowLayout()

            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5

            layout.itemSize = CGSize(width: itemSize, height: itemSize)
            layout.sectionInset = UIEdgeInsets(top: 100, left: 20, bottom: 100, right: 20)
            layout.scrollDirection = .horizontal
       
            viewCollection.collectionViewLayout = layout
            viewCollection.backgroundColor = UIColor.lightGray

            // Tính toán kích thước thực tế của UICollectionView dựa trên số hàng và số cột
            let collectionViewWidth = CGFloat(columns) * itemSize + CGFloat(columns - 1) * 5
            let collectionViewHeight = CGFloat(rows) * itemSize + CGFloat(rows - 1) * 5

            // Cập nhật kích thước của UICollectionView và contentSize của scrollView
            viewCollection.frame.size = CGSize(width: collectionViewWidth, height: collectionViewHeight)
          
          viewCollection.backgroundColor = .gray
           

            // Đảm bảo scrollView có thể cuộn ngang
            viewCollection.isScrollEnabled = true
          
        }
    func bindingCollectionviewcell() {
        viewModel!.dataArray.bind(to: viewCollection.rx.items(cellIdentifier: "ItemChairCollectionViewCell", cellType: ItemChairCollectionViewCell.self)) { (index, element, cell) in
        
        
        
        
        }.disposed(by: BookingChairViewController.rxbag)
    }
    
}
