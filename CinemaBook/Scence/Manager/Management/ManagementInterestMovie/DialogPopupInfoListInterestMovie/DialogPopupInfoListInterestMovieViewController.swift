//
//  DialogPopupInfoListInterestMovieViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/23/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import ObjectMapper

class DialogPopupInfoListInterestMovieViewController: UIViewController {
   
  
    @IBOutlet weak var image_avatar: UIImageView!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_nameroom: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_namemovie: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    var movie = MovieList()
    var nameroom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        bindingtable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      getListMovie()
      setupvalid(movieinfo: movie)
    }
    
    func setupvalid(movieinfo: MovieList) {
        var timestarts = movie.startTime.components(separatedBy: "T")
        var timeends = movie.endTime.components(separatedBy: "T")
        var time_s = timestarts[1].components(separatedBy: ":")
        var time_e = timeends[1].components(separatedBy: ":")
        var timestart_s = time_s[0] + ":" + time_s[1]
        var timeend_s = time_e[0] + ":" + time_e[1]
        lbl_date.text = timestarts[0]
        lbl_namemovie.text = movieinfo.namemovie
        lbl_time.text = timestart_s + "-" + timeend_s
        lbl_nameroom.text = nameroom
        image_avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: movieinfo.image)), placeholder:  UIImage(named: "image_defauft_medium"))
    }

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
   
    @IBAction func btn_access(_ sender: Any) {
    }
    
    var viewModel: ManagementInterestMoviesViewModel? = nil {
        didSet{
            
        }
    }
    
    
}

extension DialogPopupInfoListInterestMovieViewController {
    func getListMovie() {
        self.viewModel!.getListMovieShow().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Movie>().mapArray(JSONObject: response.data)
                {
                    self.viewModel!.dataArrayMovie.accept(data)
                  
                }
            }
        })
    }
}

extension DialogPopupInfoListInterestMovieViewController {
    func register() {
        let collectionviewcell = UINib(nibName: "ItemInterestMovieListManagementCollectionViewCell", bundle: .main)
        collectionview.register(collectionviewcell, forCellWithReuseIdentifier: "ItemInterestMovieListManagementCollectionViewCell")
        setupCollectionView()
        collectionview.rx.modelSelected(Movie.self).subscribe(onNext:{ element in
            dLog(element)
            var datas = self.viewModel?.dataArrayMovie.value
            self.lbl_nameroom.text = element.namemovie
            self.image_avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: element.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
            datas?.enumerated().forEach{
                (index,value) in
                if value.movieID == element.movieID  {
                    datas![index].isSelected = ACTIVE
                    
                }else
                {
                    datas![index].isSelected = DEACTIVE
                }
            }
            self.viewModel?.dataArrayMovie.accept(datas!)
        })
     
       
    }
    
    func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 200, height: 100)
            layout.minimumLineSpacing = 5
            collectionview.collectionViewLayout = layout
            collectionview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            collectionview.translatesAutoresizingMaskIntoConstraints = false
            }
    
    func bindingtable() {
        viewModel?.dataArrayMovie.bind(to: collectionview.rx.items(cellIdentifier: "ItemInterestMovieListManagementCollectionViewCell", cellType: ItemInterestMovieListManagementCollectionViewCell.self)) {
            (row,data,cell) in
            cell.data = data
          
//
        }
    }
}
