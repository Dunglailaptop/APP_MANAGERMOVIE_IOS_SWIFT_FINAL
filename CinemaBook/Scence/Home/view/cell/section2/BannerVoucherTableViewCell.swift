//
//  BannerVoucherTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/7/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BannerVoucherTableViewCell: UITableViewCell {

    @IBOutlet weak var collection_view: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
          register()
        collection_view.delegate = self
        collection_view.dataSource = self
        // Initialization code
    }
   private(set) var disposeBag = DisposeBag()
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: HomeViewModel?
    {
        didSet {
         
            viewModel?.dataArrayVoucher.subscribe(onNext: {
                [self] data in
                self.collection_view.reloadData()
            })
        }
    }
    
    
}

extension BannerVoucherTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func register() {
        let viewCollection  = UINib(nibName: "ItemVoucherCollectionViewCell", bundle: .main)
        collection_view.register(viewCollection, forCellWithReuseIdentifier: "ItemVoucherCollectionViewCell")
       
        setupCollection()
    }
    func setupCollection() {
         let layout  = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.itemSize = CGSize(width: 200, height: 200)
         collection_view.collectionViewLayout = layout
     }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return (viewModel?.dataArrayVoucher.value.count)!
       }
       
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemVoucherCollectionViewCell", for: indexPath) as! ItemVoucherCollectionViewCell
        cell.lbl_title.text = viewModel?.dataArrayVoucher.value[indexPath.item].namevoucher
        cell.image_poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: (viewModel?.dataArrayVoucher.value[indexPath.item].poster)!)), placeholder:  UIImage(named: "image_defauft_medium"))
           // Configure the cell

           return cell
       }
    
}

