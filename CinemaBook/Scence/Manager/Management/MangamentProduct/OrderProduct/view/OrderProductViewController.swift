//
//  OrderProductViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ObjectMapper

class OrderProductViewController: BaseViewController {
    
   
   
    var viewModel = OrderProductViewModel()
    var router = OrderProductRouter()
   
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var height_btn_creata: NSLayoutConstraint!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var type = 0
    
    @IBOutlet weak var view_of_button_create: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        register()
        bindCollecion()
        txt_search.rx.controlEvent(.editingChanged)
                   .withLatestFrom(txt_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       guard self != nil else { return }
                
                       let dataFirsts = viewModel.dataArraySearch.value
                       let cloneDataFilter = viewModel.dataArray.value
                       if !query!.isEmpty{
                           var filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               let str2 = value.nametittle.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               return str2!.contains(str1!)
                           })
                           viewModel.dataArray.accept(filteredDataArray)
                      
                       }else{
                           viewModel.dataArray.accept(dataFirsts)
                          
                          
                       }
                       
                   }).disposed(by: rxbag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListFoodCombo()
        switch type {
        case 0:
       
            height_btn_creata.constant = 60
            view_of_button_create.isHidden = false
        case 1:
           
            height_btn_creata.constant = 0
            view_of_button_create.isHidden = true
          
        default:
            return
        }
    }
    
    
    
    @IBAction func btn_makeToCreateProductViewController(_ sender: Any) {
        viewModel.makeToCreateProductViewController()
    }
    
}


extension OrderProductViewController {
    func register() {
        let cellCollection = UINib(nibName: "ItemProductOrderCollectionViewCell", bundle: .main)
        collectionView.register(cellCollection, forCellWithReuseIdentifier: "ItemProductOrderCollectionViewCell")
        collectionView.rx.modelSelected(FoodCombo.self).subscribe(onNext: { [self] element in
            
            type == 1 ? viewModel.makeToDetailStoreViewController(foodcombo: element) : self.viewModel.makeToDetailViewController(foodcomboss: element)
            
        })
        setupCollection()
    }
    
    func setupCollection() {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical // Đặt hướng cuộn là dọc
          
          let collectionViewWidth = view.frame.size.width
        let cellWidth = (collectionViewWidth - 10)/2
        dLog(collectionView.frame.size.width)
          dLog(cellWidth)
          layout.itemSize = CGSize(width: cellWidth, height: 250)
         // Add constraints here
        
        
          
          collectionView.collectionViewLayout = layout
          
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollection()
    }

    
    func bindCollecion() {
        viewModel.dataArray.bind(to: collectionView.rx.items(cellIdentifier: "ItemProductOrderCollectionViewCell", cellType: ItemProductOrderCollectionViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
extension OrderProductViewController {
    func getListFoodCombo() {
        viewModel.getListFoodCombo().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<FoodCombo>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArraySearch.accept(data)
                    self.viewModel.dataArray.accept(data)
                }
            }
        })
    }
 
}
