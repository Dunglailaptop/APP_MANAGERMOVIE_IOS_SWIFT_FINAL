//
//  headerTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper

class headerTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCollectionview()
    
    }
    
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var viewModel: BookingChairViewModel? = nil {
        didSet {
          getListCategoryChairInRoom()
            NotificationCenter.default.addObserver(self, selector: #selector(self.onDidReceiveNotification(_:)), name: NSNotification.Name("NotificationCallApi"), object: nil)
        }
    }
    
    @objc func onDidReceiveNotification(_ notification: Notification)
      {
       
          
        dLog(notification.userInfo?["userInfo"])
        var Idroom = notification.userInfo?["userInfo"]
          var data = viewModel!.pagition.value
        data.idroom = Idroom as! Int
          viewModel!.pagition.accept(data)
       getListCategoryChairInRoom()
      }
}

extension headerTableViewCell {
    func getListCategoryChairInRoom() {
        viewModel?.getListCategoryChairRoom().subscribe(onNext: { [self]
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<CategoryChair>().mapArray(JSONObject: response.data) {
                    self.viewModel?.ChairCategory.accept(data)
                    viewCollection.reloadData()
                }
            }
        })
    }
    
    
     func registerCollectionview() {
            let collectionviewcell = UINib(nibName: "ItemChairCategoryCollectionViewCell", bundle: .main)
            viewCollection.register(collectionviewcell, forCellWithReuseIdentifier: "ItemChairCategoryCollectionViewCell")
           setupCollectionView(itemSize: 150)
        }
        
        func setupCollectionView(itemSize: CGFloat) {
            viewCollection.delegate = self
            viewCollection.dataSource = self
             let layout = UICollectionViewFlowLayout()

             layout.minimumInteritemSpacing = 5
             layout.minimumLineSpacing = 5

             layout.itemSize = CGSize(width: itemSize, height: itemSize) // Chỉ rộng mà không cao
             layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
             layout.scrollDirection = .horizontal
             
             viewCollection.collectionViewLayout = layout
             viewCollection.backgroundColor = ColorUtils.backgroudcolor()

      

             // Đảm bảo scrollView có thể cuộn ngang
             viewCollection.isScrollEnabled = true
         }


       
}
extension headerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.ChairCategory.value.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = viewCollection.dequeueReusableCell(withReuseIdentifier: "ItemChairCategoryCollectionViewCell", for: indexPath) as! ItemChairCategoryCollectionViewCell
        cell.view_colorchair.backgroundColor = UIColor(hex: (viewModel?.ChairCategory.value[indexPath.row].colorchair.removeCharacters(from: "#"))!) 
        cell.lbl_name_chair.text = viewModel?.ChairCategory.value[indexPath.row].namecategorychair
        return cell
    }
}
