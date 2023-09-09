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
         
            bindingcollectionview()
        }
    }
    
    
}

extension BannerVoucherTableViewCell {
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
    
    func bindingcollectionview() {
        viewModel?.dataArrayVoucher.bind(to: collection_view.rx.items(cellIdentifier: "ItemVoucherCollectionViewCell", cellType: ItemVoucherCollectionViewCell.self)) {[self] (row,data,cell) in
            cell.data = data
        }.disposed(by: disposeBag)
    }
}

