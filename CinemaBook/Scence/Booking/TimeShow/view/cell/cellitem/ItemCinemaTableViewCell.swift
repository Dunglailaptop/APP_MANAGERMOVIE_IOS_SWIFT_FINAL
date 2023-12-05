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


class ItemCinemaTableViewCell: UITableViewCell, UICollectionViewDataSource {

    @IBOutlet weak var view_height: NSLayoutConstraint!
    @IBOutlet weak var btn_show_all: UIButton!
    @IBOutlet weak var view_of_collection: UIView!
    @IBOutlet weak var view_collection: UICollectionView!
    
    @IBOutlet weak var lbl_namecinema: UILabel!
    @IBOutlet weak var icon_dropdown: UIImageView!
    
    var rxbag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        let collectionview = UINib(nibName: "itemTimeCollectionViewCell", bundle: .main)
        view_collection.register(collectionview, forCellWithReuseIdentifier: "itemTimeCollectionViewCell")
        self.view_collection.delegate = self
        self.view_collection.dataSource = self
        self.setupCollectionView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
    var data: ModelinterestMovie? = nil {
        didSet {
            lbl_namecinema.text = data?.namecinema
        }
    }
    
    var viewModel: TimeShowViewModel? = nil {
        didSet{
          
            viewModel?.listCinemaWithInterest.subscribe(onNext: {
                [self] data in
               
               
                self.view_collection.reloadData()
            })
        }
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

}

extension ItemCinemaTableViewCell: UICollectionViewDelegate {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (data?.listinterest.count)!
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemTimeCollectionViewCell", for: indexPath) as! itemTimeCollectionViewCell
    cell.viewModel = self.viewModel
    cell.idcinema = data?.listinterest[indexPath.row].idcinema as! Int
    cell.idroom = data?.listinterest[indexPath.row].idroom as! Int
    cell.idinterest = data?.listinterest[indexPath.row].idinterest as! Int
    cell.lbl_time.text = String((data?.listinterest[indexPath.row].times)!)
    cell.idmovie = data?.listinterest[indexPath.row].idmovie as! Int
    cell.namemovie = data?.listinterest[indexPath.row].namecinema as! String
    dLog(data?.listinterest[indexPath.row].times)
    
    return cell
}

}
