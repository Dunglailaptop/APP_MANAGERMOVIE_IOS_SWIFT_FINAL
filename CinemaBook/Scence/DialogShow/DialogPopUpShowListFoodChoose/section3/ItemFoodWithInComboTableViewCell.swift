//
//  ItemFoodWithInComboTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 12/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemFoodWithInComboTableViewCell: UITableViewCell {

    @IBOutlet weak var collection_view: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let controller = UINib(nibName: "ItemFoodWithinComboCollectionViewCell", bundle: .main)
        collection_view.register(controller, forCellWithReuseIdentifier: "ItemFoodWithinComboCollectionViewCell")
        setupCollection()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var viewModel: DetailProductViewModel? = nil {
        didSet {
            collection_view.reloadData()
           
        }
    }
    
}
extension ItemFoodWithInComboTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func setupCollection() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 40)
        collection_view.dataSource = self
        collection_view.delegate = self
        collection_view.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.dataArrayFoodincombo.value.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemFoodWithinComboCollectionViewCell", for: indexPath) as!  ItemFoodWithinComboCollectionViewCell
        dLog(viewModel?.dataArrayFoodincombo.value)
        cell.name_food.text = viewModel?.dataArrayFoodincombo.value[indexPath.row].namefood
        cell.image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: (viewModel?.dataArrayFoodincombo.value[indexPath.row].picture)!)), placeholder:  UIImage(named: "image_defauft_medium"))
        return cell
    }
    
}
