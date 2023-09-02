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
    @IBOutlet weak var height_view_search: NSLayoutConstraint!
    
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var txt_searchs: UITextField!
  
    var viewModel = MovieViewModel()
    var router = MovieRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router )
        register()
        bindingCollectionviewcell()
        // Do any additional setup after loading the view.
    }


    @IBAction func btn_stopsearch(_ sender: Any) {
        height_view_search.constant = 0
        txt_searchs.text = ""
        view_search.isHidden = true
    }
    

    @IBAction func btn_search(_ sender: Any) {
        height_view_search.constant = 250
        view_search.isHidden = false
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
            layout.minimumLineSpacing = 10
            collectionViews.collectionViewLayout = layout
            collectionViews.backgroundColor = ColorUtils.gray_6()
            collectionViews.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            collectionViews.translatesAutoresizingMaskIntoConstraints = false
        }
    func bindingCollectionviewcell() {
        viewModel.dataArray.bind(to: collectionViews.rx.items(cellIdentifier: "MovieItemCollectionViewCell", cellType: MovieItemCollectionViewCell.self)) { (index, data,cell) in
            
            
        }.disposed(by: rxbag)
    }
}
