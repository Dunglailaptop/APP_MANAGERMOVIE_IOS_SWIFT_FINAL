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
  
    @IBOutlet weak var lbl_name_movie: UILabel!
    @IBOutlet weak var collection_view: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
          register()
        collection_view.delegate = self
        collection_view.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: HomeViewModel? {
        didSet {
          
            viewModel?.dataArrayMovie.subscribe(onNext: {
                [self] data in
                self.collection_view.reloadData()
            })
        
        }
    }
    
    var data: Movie? = nil {
        didSet {
            
        }
    }
    

    
    
}
extension BannerMovieTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate {
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.dataArrayMovie.value.count)!
    }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlimsCollectionViewCell", for: indexPath) as! FlimsCollectionViewCell
           dLog(indexPath.item)
      lbl_name_movie.text = viewModel?.dataArrayMovie.value[indexPath.item].namemovie
        cell.image_poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: (viewModel?.dataArrayMovie.value[indexPath.row].poster)!)), placeholder:  UIImage(named: "image_defauft_medium"))
         
          // Configure the cell

          return cell
       }
}

