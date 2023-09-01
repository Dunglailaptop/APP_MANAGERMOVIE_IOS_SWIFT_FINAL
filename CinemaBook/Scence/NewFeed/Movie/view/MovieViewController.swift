//
//  MovieViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MovieViewController: BaseViewController {

    @IBOutlet weak var collectionViews: UICollectionView!
    
    var viewModel = MovieViewModel()
    var router = MovieRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router )
        register()
        bindingCollectionviewcell()
        // Do any additional setup after loading the view.
    }


   

}

extension MovieViewController {
    func register() {
        let MovieItemCollectionViewCell = UINib(nibName: "MovieItemCollectionViewCell", bundle: .main)
        collectionViews.register(MovieItemCollectionViewCell, forCellWithReuseIdentifier: "MovieItemCollectionViewCell")
        setupCollectionView()
    }
    
        func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: view.frame.width/2.3, height: 250)
            layout.minimumLineSpacing = 5
            collectionViews.collectionViewLayout = layout
            collectionViews.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            collectionViews.translatesAutoresizingMaskIntoConstraints = false
        }
    func bindingCollectionviewcell() {
        viewModel.dataArray.bind(to: collectionViews.rx.items(cellIdentifier: "MovieItemCollectionViewCell", cellType: MovieItemCollectionViewCell.self)) { (index, data,cell) in
            
            
        }.disposed(by: rxbag)
    }
}
