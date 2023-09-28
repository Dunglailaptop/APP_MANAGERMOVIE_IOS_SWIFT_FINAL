//
//  MangamentProductViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MangamentProductViewController: UIViewController {

    var viewModel = MangamentProductViewModel()
    var router = MangamentProductRouter()
    @IBOutlet weak var collectionview: UICollectionView!
    var view1 = OrderProductViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        registerOrderProductViewController()
        resgiter()
        bindingcollection()
        // Do any additional setup after loading the view.
    }

    func registerOrderProductViewController() {
        view1 = OrderProductViewController(nibName: "OrderProductViewController", bundle: .main) as! OrderProductViewController
        addTopCustomViewController(view1, addTopCustom: 100)
    }

    func viewControllerProduct() {
        
    }
    
    
    @IBAction func btn_makeTocreateProduct(_ sender: Any) {
        viewModel.makeToCreateViewController()
    }
    
}
extension MangamentProductViewController {
    func resgiter() {
        let collection = UINib(nibName: "ItemCollectionProductCategoryCollectionViewCell", bundle: .main)
        collectionview.register(collection, forCellWithReuseIdentifier: "ItemCollectionProductCategoryCollectionViewCell")
        setupCollectionView()
    }
    func setupCollectionView() {
                 let layout = UICollectionViewFlowLayout()
                 layout.scrollDirection = .horizontal
                 layout.itemSize = CGSize(width: 100, height: 30)
                 layout.minimumLineSpacing = 5
                 collectionview.collectionViewLayout = layout
                 collectionview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                 collectionview.translatesAutoresizingMaskIntoConstraints = false
             }
    
    func bindingcollection() {
        viewModel.dataArray.bind(to: collectionview.rx.items(cellIdentifier: "ItemCollectionProductCategoryCollectionViewCell", cellType: ItemCollectionProductCategoryCollectionViewCell.self)) {
            (row,data,cell) in
            
        }
    }
}
