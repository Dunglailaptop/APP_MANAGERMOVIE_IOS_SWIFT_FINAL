//
//  BannerTraillerVideoTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/7/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BannerTraillerVideoTableViewCell: UITableViewCell {

     private(set) var disposeBag = DisposeBag()
    
    @IBOutlet weak var collection_view: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        register()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: HomeViewModel? {
        didSet {
            
            bindingcollectionviewCell()
        }
    }
    
}
extension BannerTraillerVideoTableViewCell {
    func register() {
        let Collectioncell = UINib(nibName: "itemTraillerCollectionViewCell", bundle: .main)
        collection_view.register(Collectioncell, forCellWithReuseIdentifier: "itemTraillerCollectionViewCell")
       
        setupCollection()
    }
    
    func setupCollection() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 150)
        collection_view.collectionViewLayout = layout
    }
    
    func bindingcollectionviewCell() {
        viewModel?.dataArrayTrailler.bind(to: (collection_view.rx.items(cellIdentifier: "itemTraillerCollectionViewCell", cellType: itemTraillerCollectionViewCell.self))) { [weak self] (row,data,cell) in
            cell.data = data
            
        }.disposed(by: disposeBag)
    }
}
