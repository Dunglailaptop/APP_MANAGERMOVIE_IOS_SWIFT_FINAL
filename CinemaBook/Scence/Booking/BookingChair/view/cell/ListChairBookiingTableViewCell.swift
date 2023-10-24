//
//  ListChairBookiingTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import JonAlert

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
    
    func nootifacationSetup(chairs: chair) {
        let notificationName = Notification.Name("listchairs")
        let loginResponse = ["userInfo": ["Report_type": chairs]]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: loginResponse)
    }
    
    func registerCollectionview() {
        let collectionviewcell = UINib(nibName: "ItemChairCollectionViewCell", bundle: .main)
        viewCollection.register(collectionviewcell, forCellWithReuseIdentifier: "ItemChairCollectionViewCell")
        setupCollectionView(rows: 4, columns: 3, itemSize: 50)
        viewCollection.rx.modelSelected(chair.self).subscribe(onNext: { [self] element in
            var data = self.viewModel?.dataArray.value
            data?.enumerated().forEach{ (index,value) in
                if value.idchair == element.idchair && element.isSelected != BILL {
                    data?[index].isSelected = element.isSelected == ACTIVE ? DEACTIVE:ACTIVE
                }
                if element.bill != 0 && element.isSelected == BILL{
                    JonAlert.showError(message: "Ghê đã được đặt")
                }
            }
             self.viewModel?.dataArray.accept(data!)
            var datafilter = self.viewModel!.dataArray.value.filter{$0.isSelected == ACTIVE}
            self.viewModel?.view!.lbl_price_chair.text = Utils.stringVietnameseFormatWithNumber(amount: datafilter.map { $0.price }.reduce(0, +) ?? 0)
            self.viewModel?.view?.lbl_number_chair.text = String(datafilter.count) + " Ghế"
            self.nootifacationSetup(chairs: element)
           
        })
//        if viewModel?.view?.type == 1 {
//            viewCollection.rx.modelSelected(chair.self).subscribe(onNext: {
//                element in
//             
//            })
//        }else {
//         
//        }
      
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
            dLog(data)
            cell.data = data
        
        
        
        }.disposed(by: BookingChairViewController.rxbag)
    }
    
}
