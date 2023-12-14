//
//  ManageDetailBillFoodComboItemTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 16/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ManageDetailBillFoodComboItemTableViewCell: UITableViewCell {

    @IBOutlet weak var image_foodcombo: UIImageView!
    
    @IBOutlet weak var lbl_number_combo: UILabel!
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var txt_tittle: UITextView!
    @IBOutlet weak var lbl_price_foodcombo: UILabel!
    @IBOutlet weak var lbl_name_foodcombo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let viewcell = UINib(nibName: "ItemFoodinlistCollectionViewCell", bundle: .main)
        collection_view.register(viewcell, forCellWithReuseIdentifier: "ItemFoodinlistCollectionViewCell")
        collection_view.delegate = self
        collection_view.dataSource = self
        setupCollection()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: FoodCombo? = nil {
        didSet {
            lbl_name_foodcombo.text = data!.nametittle
            lbl_price_foodcombo.text = Utils.stringVietnameseFormatWithNumber(amount: data!.priceCombo)
            lbl_number_combo.text = "x" + String(data!.numberbuyincombo)
            image_foodcombo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder:  UIImage(named: "image_defauft_medium"))
            txt_tittle.text = data?.nametittle
        }
    }
    var viewModel: ManageDetailBillFoodAccountViewModel? = nil {
        didSet {
            collection_view.reloadData()
        }
    }
    
}
extension ManageDetailBillFoodComboItemTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.datafood.value.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemFoodinlistCollectionViewCell", for: indexPath) as! ItemFoodinlistCollectionViewCell
        cell.lbl_namefood.text = viewModel?.datafood.value[indexPath.row].namefood
        cell.lbl_number.text = "x" + String(viewModel!.datafood.value[indexPath.row].numberfood)
        cell.image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: (viewModel?.datafood.value[indexPath.row].picture)!)), placeholder: UIImage(named: "image_defauft_medium"))
        return cell
    }
    func setupCollection() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 40)
        collection_view.collectionViewLayout = layout
    }
}
