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
import ObjectMapper

class MangamentProductViewController: UIViewController {

    var viewModel = MangamentProductViewModel()
    var router = MangamentProductRouter()
    @IBOutlet weak var collectionview: UICollectionView!
    var view1 = OrderProductViewController()
    var view2 = MangamentFoodItemViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        registerOrderProductViewController()
        resgiter()
        bindingcollection()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListCategoryFood()
    }

    func registerOrderProductViewController() {
        view1 = OrderProductViewController(nibName: "OrderProductViewController", bundle: .main) as! OrderProductViewController
        addTopCustomViewController(view1, addTopCustom: 100)
        view2.remove()
    }

    func viewControllerProduct() {
      
        view2 = MangamentFoodItemViewController(nibName: "MangamentFoodItemViewController", bundle: .main) as! MangamentFoodItemViewController
              addTopCustomViewController(view2, addTopCustom: 100)
        view1.remove()
    }
    
    
    @IBAction func btn_makeTocreateProduct(_ sender: Any) {
        viewModel.makeToCreateViewController()
    }
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
}
extension MangamentProductViewController {
    func resgiter() {
        let collection = UINib(nibName: "ItemCollectionProductCategoryCollectionViewCell", bundle: .main)
        collectionview.register(collection, forCellWithReuseIdentifier: "ItemCollectionProductCategoryCollectionViewCell")
        collectionview.rx.modelSelected(CategoryFood.self).subscribe(onNext: {
            [self] element in
            if element.idcategoryfood == 3 {
                self.registerOrderProductViewController()
            }else {
                self.viewControllerProduct()
            }
        })
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
            cell.data = data
        }
    }
}
extension MangamentProductViewController {
    func getListCategoryFood() {
            viewModel.getListCategoryFood().subscribe(onNext: {
                (response) in
                if response.code == RRHTTPStatusCode.ok.rawValue{
                    if let data = Mapper<CategoryFood>().mapArray(JSONObject:response.data) {
                        self.viewModel.dataArray.accept(data)
                    }
                }
            })
        }
}
