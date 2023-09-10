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
        collection_view.dataSource = self
        collection_view.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: HomeViewModel? {
        didSet {
            viewModel?.dataArrayTrailler.subscribe(onNext: {
                [self] data in
                self.collection_view.reloadData()
            })
            
        }
    }
    
}
extension BannerTraillerVideoTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.dataArrayTrailler.value.count)!
    }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemTraillerCollectionViewCell", for: indexPath) as! itemTraillerCollectionViewCell
          cell.lbl_tittle.text = viewModel?.dataArrayTrailler.value[indexPath.item].titlevideo
    if viewModel?.dataArrayTrailler.value[indexPath.item].types == 0 {
        cell.video.load(withVideoId: (viewModel?.dataArrayTrailler.value[indexPath.item].videofile)!)

        }else {
                       
        }
        // Configure the cell

        return cell
    }

}
