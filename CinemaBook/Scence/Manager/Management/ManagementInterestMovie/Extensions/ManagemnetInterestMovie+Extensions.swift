//
//  ManagemnetInterestMovie+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 9/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension ManagementInterestMovieViewController {
    func resgister() {
        let viewCellCollection = UINib(nibName: "ItemRoomInterestCollectionViewCell", bundle: .main)
        collectionview.register(viewCellCollection, forCellWithReuseIdentifier: "ItemRoomInterestCollectionViewCell")
        setupCollectionView()
    }
    
    func setupCollectionView() {
             let layout = UICollectionViewFlowLayout()
             layout.scrollDirection = .horizontal
             layout.itemSize = CGSize(width: 100, height: 23)
             layout.minimumLineSpacing = 5
             collectionview.collectionViewLayout = layout
             collectionview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
             collectionview.translatesAutoresizingMaskIntoConstraints = false
         }
    
    func bindingCollectionviewcell() {
        viewModel.dataArrayRoom.bind(to: collectionview.rx.items(cellIdentifier: "ItemRoomInterestCollectionViewCell", cellType: ItemRoomInterestCollectionViewCell.self))
        { (row,data,cell) in
            
            
            
        }
    }
}
extension ManagementInterestMovieViewController: SambagDatePickerViewControllerDelegate {
    
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult){
        self.lbl_dateTo.text = result.description
        var date = viewModel.dataDay.value
        date.DateForm = Utils().convertdatetime(string: result.description)
        viewModel.dataDay.accept(date)
        viewController.dismiss(animated: true, completion: nil)
     }
     
     func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
         viewController.dismiss(animated: true, completion: nil)
     }
     
     func showDateTimePicker(dateTimeData:String){

         let vc = SambagDatePickerViewController()
         var limit = SambagSelectionLimit()
         
         var dateNow = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd/MM/yyyy"
         dateNow = dateFormatter.date(from: dateTimeData) ?? dateNow
         limit.selectedDate = dateNow

         // Set the minimum and maximum selectable dates
         let calendar = Calendar.current
         let currentDate = Date()
         let minDate = calendar.date(byAdding: .year, value: -1000, to: currentDate) // One year ago
         let maxDate = calendar.date(byAdding: .year, value: 1000, to: currentDate) // One year from now

         limit.minDate = minDate
         limit.maxDate = maxDate
         vc.limit = limit
         vc.delegate = self
         present(vc, animated: true, completion: nil)
        }
}
