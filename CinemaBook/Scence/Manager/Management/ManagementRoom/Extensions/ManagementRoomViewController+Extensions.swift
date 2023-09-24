//
//  ManagementRoomViewController+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

extension ManagementRoomViewController {
       func getListRoom(){
           viewModel.getListRoom().subscribe(onNext: {
               (response) in
               if response.code == RRHTTPStatusCode.ok.rawValue {
                   if let data = Mapper<Room>().mapArray(JSONObject: response.data) {
                       self.viewModel.dataArrayRoom.accept(data)
                  
                   }
               }
           })
       }
    
    func getListCategoryChair() {
        viewModel.getListCategoryChair().subscribe(onNext: {
                      (response) in
                      if response.code == RRHTTPStatusCode.ok.rawValue {
                          if let data = Mapper<CategoryChair>().mapArray(JSONObject: response.data) {
                              self.viewModel.dataArrayCategoryChair.accept(data)
                         
                          }
                      }
                  })
    }

}

extension ManagementRoomViewController {
    func register() {
        let cellColletion = UINib(nibName: "itemRoomsCollectionViewCell", bundle: .main)
        Collectionview.register(cellColletion, forCellWithReuseIdentifier: "itemRoomsCollectionViewCell")
        setupCollectionView()
    }
    func bindingCollectionCell() {
        viewModel.dataArrayRoom.bind(to: Collectionview.rx.items(cellIdentifier: "itemRoomsCollectionViewCell", cellType: itemRoomsCollectionViewCell.self)) {
            (row,data,cell) in
             cell.data = data
        }
    }
    func registerCategory() {
        let cellCollectionCategory = UINib(nibName: "ItemCategoryChairCollectionViewCell", bundle: .main)
        collectionView_category_chair.register(cellCollectionCategory, forCellWithReuseIdentifier: "ItemCategoryChairCollectionViewCell")
        setupCollectionViewCategory()
    }
    
    func bindingCollectionCategory() {
        viewModel.dataArrayCategoryChair.bind(to: collectionView_category_chair.rx.items(cellIdentifier:"ItemCategoryChairCollectionViewCell" , cellType: ItemCategoryChairCollectionViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
    func setupCollectionView() {
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                layout.itemSize = CGSize(width: 100, height: 23)
                layout.minimumLineSpacing = 5
                Collectionview.collectionViewLayout = layout
                Collectionview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                Collectionview.translatesAutoresizingMaskIntoConstraints = false
            }
    func setupCollectionViewCategory() {
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                layout.itemSize = CGSize(width: 150, height: 30)
                layout.minimumLineSpacing = 5
                collectionView_category_chair.collectionViewLayout = layout
                collectionView_category_chair.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                collectionView_category_chair.translatesAutoresizingMaskIntoConstraints = false
            }
}
