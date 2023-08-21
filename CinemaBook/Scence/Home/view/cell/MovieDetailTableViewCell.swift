//
//  MovieDetailTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 7/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {


  
    
    var hinh = ["h1","h2","h3","h4"]
    var mycollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        mycollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
       contentView.addSubview(mycollection)
        mycollection.translatesAutoresizingMaskIntoConstraints = false
        mycollection.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mycollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        mycollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mycollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mycollection.backgroundColor = UIColor.clear
        mycollection.dataSource = self
        mycollection.delegate = self
        
        mycollection.register(CustomCollection.self, forCellWithReuseIdentifier: "cell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MovieDetailTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return hinh.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mycollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollection
        cell.bridImageView.image = UIImage(named: hinh[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width/2-20, height: contentView.frame.height)
    }
}
class CustomCollection: UICollectionViewCell {
    
    let bridImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bridImageView)
        bridImageView.translatesAutoresizingMaskIntoConstraints = false
        bridImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bridImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        bridImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bridImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bridImageView.layer.cornerRadius = 20
        bridImageView.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has been implemented")
    }
}
