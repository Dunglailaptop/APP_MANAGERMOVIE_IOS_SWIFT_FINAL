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
        setupCollectionView(rows: 4, columns: 3, itemSize: 50)
    }
    
    func setupCollectionView(rows: Int, columns: Int, itemSize: CGFloat) {
            let layout = UICollectionViewFlowLayout()

            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5

            layout.itemSize = CGSize(width: itemSize, height: itemSize)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            layout.scrollDirection = .horizontal
        layout.scrollDirection = .vertical
            viewCollection.collectionViewLayout = layout
            viewCollection.backgroundColor = ColorUtils.backgroudcolor()

            // Tính toán kích thước thực tế của UICollectionView dựa trên số hàng và số cột
            let collectionViewWidth = CGFloat(columns) * itemSize + CGFloat(columns - 1) * 5
            let collectionViewHeight = CGFloat(rows) * itemSize + CGFloat(rows - 1) * 5

            // Cập nhật kích thước của UICollectionView và contentSize của scrollView
            viewCollection.frame.size = CGSize(width: collectionViewWidth, height: collectionViewHeight)




            // Đảm bảo scrollView có thể cuộn ngang
            viewCollection.isScrollEnabled = true

        }
//  func setupCollectionView(rows: Int, columns: Int, itemSize: CGFloat) {
//      let layout = UICollectionViewFlowLayout()
//
//      layout.minimumInteritemSpacing = 5
//      layout.minimumLineSpacing = 5
//
//      layout.itemSize = CGSize(width: itemSize, height: itemSize)
//      layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
//      layout.scrollDirection = .horizontal
//
//      viewCollection.collectionViewLayout = layout
//      viewCollection.backgroundColor = ColorUtils.backgroudcolor()
//
//      // Tính toán kích thước thực tế của UICollectionView dựa trên số hàng và số cột
//      let collectionViewWidth = CGFloat(columns) * (itemSize + layout.minimumInteritemSpacing)
//      let collectionViewHeight = CGFloat(rows) * (itemSize + layout.minimumLineSpacing)
//
//      // Cập nhật kích thước của UICollectionView và contentSize của scrollView
//      viewCollection.frame.size = CGSize(width: collectionViewWidth, height: collectionViewHeight)
//      viewCollection.contentSize = CGSize(width: collectionViewWidth, height: collectionViewHeight)
//
//      // Đảm bảo scrollView có thể cuộn ngang
//      viewCollection.isScrollEnabled = true
//
//      // Xác định ràng buộc để đặt vị trí và kích thước của collectionView
//  }



    func bindingCollectionviewcell() {
        viewModel!.dataArray.bind(to: viewCollection.rx.items(cellIdentifier: "ItemChairCollectionViewCell", cellType: ItemChairCollectionViewCell.self)) { (index, data, cell) in
            
//            // Tính chỉ số hàng và chỉ số cột từ vị trí index
//                  let row = index / 10
//                  let col = index % 10
//
//                  // Tính chỉ số của phần tử từ chỉ số của cell
//                  let itemIndex = row * 10 + col
//            dLog(index)
//            dLog(cell)
//            dLog(data)
            cell.number = data
        
        
        
        }.disposed(by: BookingChairViewController.rxbag)
    }
    
}
