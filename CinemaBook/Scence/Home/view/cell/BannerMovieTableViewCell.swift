//
//  BannerMovieTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/7/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import LNICoverFlowLayout
import RxCocoa
import RxSwift

class BannerMovieTableViewCell: UITableViewCell {


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
          
            bindingcollectionviewcell()
        
        }
    }
    
    var data: Movie? = nil {
        didSet {
            
        }
    }
    

    
    
}
extension BannerMovieTableViewCell {
        func register() {
            let viewcollectioncell = UINib(nibName: "FlimsCollectionViewCell", bundle: .main)
            collection_view.register(viewcollectioncell, forCellWithReuseIdentifier: "FlimsCollectionViewCell")
            
            setupcollection()
        }
        
        func setupcollection() {
                      let layout = LNICoverFlowLayout()
            layout.scrollDirection = .horizontal
            
                     layout.maxCoverDegree = 45
                        layout.coverDensity = 0.05
                      layout.minCoverScale = 0.72
                        layout.minCoverOpacity = 0.5
            layout.itemSize = CGSize(width: 300, height: 300)
                        collection_view.collectionViewLayout = layout
            collection_view.isPagingEnabled = false
   
        }
        
        func bindingcollectionviewcell() {
            viewModel?.dataArrayMovie.bind(to: (collection_view.rx.items(cellIdentifier: "FlimsCollectionViewCell", cellType: FlimsCollectionViewCell.self))) { [weak self] (row,data,cell) in
                cell.data = data
                cell.viewModel = self?.viewModel
       
            }.disposed(by: disposeBag)
        }
}

