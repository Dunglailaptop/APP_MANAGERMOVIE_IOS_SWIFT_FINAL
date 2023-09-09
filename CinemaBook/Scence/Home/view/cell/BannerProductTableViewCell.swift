//
//  BannerProductTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/8/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FSPagerView

class BannerProductTableViewCell: UITableViewCell {

  
    @IBOutlet weak var collection_view: UICollectionView!
    
    private(set) var disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
          register()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var viewModel: HomeViewModel?{
        didSet {
          
            bindingcollectionview()
        }
    }
    
}
extension BannerProductTableViewCell {
    func register() {
        let viewCollection  = UINib(nibName: "itemProductCollectionViewCell", bundle: .main)
               collection_view.register(viewCollection, forCellWithReuseIdentifier: "itemProductCollectionViewCell")
       
               setupCollection()
    }
    func setupCollection() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: collection_view.frame.size.width, height: 200)
        collection_view.collectionViewLayout = layout
    }
    func bindingcollectionview() {
        viewModel?.dataArrayProduct.bind(to: collection_view.rx.items(cellIdentifier: "itemProductCollectionViewCell", cellType: itemProductCollectionViewCell.self)) {[self] (row,data,cell) in
            
        }.disposed(by: disposeBag)
    }
}

