//
//  ItemCinemaTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/29/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ItemCinemaTableViewCell: UITableViewCell {

    @IBOutlet weak var view_height: NSLayoutConstraint!
    @IBOutlet weak var btn_show_all: UIButton!
    @IBOutlet weak var view_of_collection: UIView!
    @IBOutlet weak var view_collection: UICollectionView!
    
    @IBOutlet weak var lbl_namecinema: UILabel!
    @IBOutlet weak var icon_dropdown: UIImageView!
    
    var rxbag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
    var data: InterestMovie? = nil {
        didSet {
            lbl_namecinema.text = data?.namecinema
        }
    }
    
    var viewModel: TimeShowViewModel? = nil {
        didSet{
            register()
            bindingCollectionViewCell()
        }
    }
    
}

extension ItemCinemaTableViewCell {
    func register() {
        let itemTimeCollectionviewcell = UINib(nibName: "itemTimeCollectionViewCell", bundle: .main)
        view_collection.register(itemTimeCollectionviewcell, forCellWithReuseIdentifier: "itemTimeCollectionViewCell")
        setupCollectionView()
    }
    
    func setupCollectionView() {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .horizontal
          layout.itemSize = CGSize(width: 60, height: 23)
          layout.minimumLineSpacing = 5
          view_collection.collectionViewLayout = layout
          view_collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
          view_collection.translatesAutoresizingMaskIntoConstraints = false
      }
    
    func bindingCollectionViewCell() {
        viewModel?.listTime.bind(to: view_collection.rx.items(cellIdentifier: "itemTimeCollectionViewCell", cellType: itemTimeCollectionViewCell.self)) { (index, data, cell) in
            cell.data = data
            cell.btn_makeToBookingChairViewController.rx.tap.asDriver().drive(onNext: {[weak self] in
                self?.viewModel?.navigationToBookingChairViewController()
            }).disposed(by: self.rxbag)
            
        }.disposed(by: rxbag)
    }
}
