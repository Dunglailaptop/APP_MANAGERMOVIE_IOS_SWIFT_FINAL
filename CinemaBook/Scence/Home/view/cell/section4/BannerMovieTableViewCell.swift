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

    
    @IBOutlet weak var lbl_tittle_movie_comingsoon: UILabel!
    
    @IBOutlet weak var lbl_tittle_movienow: UILabel!
    @IBOutlet weak var view_newcomingsoon: UIView!
    @IBOutlet weak var view_movieticket: UIView!
    
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
    
    @IBAction func btn_choose_movie_new(_ sender: Any) {
        lbl_tittle_movienow.textColor = .white
        view_movieticket.backgroundColor = .white
        lbl_tittle_movie_comingsoon.textColor = .black
        view_newcomingsoon.backgroundColor = .clear
        postnotifaction(status: 1)
    }
    
    @IBAction func btn_choose_movie_newcoming(_ sender: Any) {
        lbl_tittle_movienow.textColor = .black
        view_movieticket.backgroundColor = .clear
        lbl_tittle_movie_comingsoon.textColor = .white
        view_newcomingsoon.backgroundColor = .white
        postnotifaction(status: 0)
    }
    
    func postnotifaction(status:Int) {
        let notificationName = Notification.Name("CALLGETLISTSTATUS")
        let loginResponse = ["userInfo": ["Report_type": status]]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: loginResponse)
    }
}
extension BannerMovieTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dLog(viewModel?.dataArrayMovie.value[indexPath.row].movieID)
        var idmovies = (viewModel?.dataArrayMovie.value[indexPath.row].movieID)!
        self.viewModel?.maketoDetailViewContrller(idmovie: idmovies)
    }

    
        func register() {
            let viewcollectioncell = UINib(nibName: "FlimsCollectionViewCell", bundle: .main)
            collection_view.register(viewcollectioncell, forCellWithReuseIdentifier: "FlimsCollectionViewCell")
            collection_view.delegate = self
//            collection_view.rx.modelSelected(Movie.self).subscribe(onNext: {
//                element in
//                dLog(element)
//            })
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
           cell.viewModel = viewModel
          // Configure the cell

          return cell
       }
}

