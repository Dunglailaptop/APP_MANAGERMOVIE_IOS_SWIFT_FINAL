//
//  DialogItemInterestMovieTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/23/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class DialogItemInterestMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var view_collectionview: UIView!
    @IBOutlet weak var collectionview: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        register()
      self.collectionview.delegate = self
     self.collectionview.dataSource = self
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: ManagementInterestMovieViewModel? = nil {
        didSet{
            
        }
    }
    
    var data: MovieList? = nil {
        didSet {
            var DateTime = data?.startTime.components(separatedBy: "T")
            lbl_date.text = DateTime![0]
        }
    }
    
    @IBAction func btn_show_all(_ sender: Any) {
        view_collectionview.isHidden = view_collectionview.isHidden == true ? false:true
    }
    func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 150, height: 23)
            layout.minimumLineSpacing = 5
            collectionview.collectionViewLayout = layout
            collectionview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            view_collectionview.translatesAutoresizingMaskIntoConstraints = false
        }
    
}
extension DialogItemInterestMovieTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.dataArrayInterestInfo.value.count)!
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemInterestMovieListManagementCollectionViewCell", for: indexPath) as! ItemInterestMovieListManagementCollectionViewCell
        
       var times = viewModel?.dataArrayInterestInfo.value[indexPath.item].startTime.components(separatedBy: "T")
        cell.lbl_time.text = times![1]
         return cell
     }
    
    func register() {
        let cellCollection = UINib(nibName: "ItemInterestMovieListManagementCollectionViewCell", bundle: .main)
        collectionview.register(cellCollection, forCellWithReuseIdentifier: "ItemInterestMovieListManagementCollectionViewCell")
    }
}
