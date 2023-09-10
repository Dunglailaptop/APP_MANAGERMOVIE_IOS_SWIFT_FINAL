//
//  BookingChairViewController+Extension.swift
//  CinemaBookTests
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ObjectMapper

//CALL API
extension BookingChairViewController {
    func getListchair() {
        viewModel.getListchair().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<chair>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                }
            }
            }).disposed(by: rxbag)
    }
}

extension BookingChairViewController {
    
    static let rxbag = DisposeBag()
    
    func resgisterCollection(){
        let movietableviewcell = UINib(nibName: "headerTableViewCell", bundle: .main)
        tableView.register(movietableviewcell, forCellReuseIdentifier: "headerTableViewCell")
        let ListchairBooking = UINib(nibName: "ListChairBookiingTableViewCell", bundle: .main)
        tableView.register(ListchairBooking, forCellReuseIdentifier: "ListChairBookiingTableViewCell")
       let ListCategoryChair = UINib(nibName: "ListCategoryChairTableViewCell", bundle: .main)
             tableView.register(ListCategoryChair, forCellReuseIdentifier: "ListCategoryChairTableViewCell")
              tableView.rx.setDelegate(self).disposed(by:rxbag)
        
        
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        self.tableView.addGestureRecognizer(pinchGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        self.tableView.addGestureRecognizer(panGesture)
//
//      setupCollectionView(rows: 20, columns: 20,itemSize: 50)
    }
    
//    @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
//        if gesture.state == .changed {
//            let currentScale = view_collection.transform.a
//            let newScale = currentScale * gesture.scale
//
//            // Set a minimum and maximum scale to limit zooming
//            let minScale: CGFloat = 0.5
//            let maxScale: CGFloat = 3.0
//            let scaledValue = min(max(newScale, minScale), maxScale)
//
//            view_collection.transform = CGAffineTransform(scaleX: scaledValue, y: scaledValue)
//            gesture.scale = 1.0
//        }
//    }

// @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
//        if gesture.state == .changed {
//            let currentScale = tableView.transform.a
//            let newScale = currentScale * gesture.scale
//
//            // Set a minimum and maximum scale to limit zooming
//            let minScale: CGFloat = 0.5
//            let maxScale: CGFloat = 3.0
//            let scaledValue = min(max(newScale, minScale), maxScale)
//
//            tableView.transform = CGAffineTransform(scaleX: scaledValue, y: scaledValue)
//
//            // Calculate the new width and height based on the scaled value
//            let newWidth = originalCollectionViewSize.width * scaledValue
//            let newHeight = originalCollectionViewSize.height * scaledValue
//
//            // Calculate the x and y translation needed to keep it centered
//            let xOffset = (originalCollectionViewSize.width - newWidth) / 2.0
//            let yOffset = (originalCollectionViewSize.height - newHeight) / 2.0
//
//            // Update the frame and transform of the UICollectionView
//            tableView.frame = CGRect(x: scroll_view_zoom.frame.origin.x + xOffset, y: scroll_view_zoom.frame.origin.y + yOffset, width: newWidth, height: newHeight)
//
//            gesture.scale = 1.0
//        }
//    }
//
//
//
//
//
//    @objc private func didPan(_ gesture: UIPanGestureRecognizer) {
//        if gesture.state == .changed {
//            let translation = gesture.translation(in: tableView)
//            tableView.transform = tableView.transform.translatedBy(x: translation.x, y: translation.y)
//            gesture.setTranslation(CGPoint.zero, in: tableView)
//        }
//    }
    
    @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            let currentScale = tableView.transform.a
            let newScale = currentScale * gesture.scale

            // Set a minimum and maximum scale to limit zooming
            let minScale: CGFloat = 0.5
            let maxScale: CGFloat = 3.0
            let scaledValue = min(max(newScale, minScale), maxScale)

            tableView.transform = CGAffineTransform(scaleX: scaledValue, y: scaledValue)
            
            // Reset the gesture's scale to avoid compounding the scaling effect
            gesture.scale = 1.0
        }
    }

    @objc private func didPan(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            let translation = gesture.translation(in: tableView)
            tableView.transform = tableView.transform.translatedBy(x: translation.x, y: translation.y)
            gesture.setTranslation(CGPoint.zero, in: tableView)
        }
    }

    
    
      func setupCollectionView(rows: Int, columns: Int, itemSize: CGFloat) {
          let layout = UICollectionViewFlowLayout()

          layout.minimumInteritemSpacing = 5
          layout.minimumLineSpacing = 5

          layout.itemSize = CGSize(width: itemSize, height: itemSize)
          layout.sectionInset = UIEdgeInsets(top: 100, left: 20, bottom: 100, right: 20)
          layout.scrollDirection = .horizontal
     
          view_collection.collectionViewLayout = layout
          view_collection.backgroundColor = UIColor.lightGray

          // Tính toán kích thước thực tế của UICollectionView dựa trên số hàng và số cột
          let collectionViewWidth = CGFloat(columns) * itemSize + CGFloat(columns - 1) * 5
          let collectionViewHeight = CGFloat(rows) * itemSize + CGFloat(rows - 1) * 5

          // Cập nhật kích thước của UICollectionView và contentSize của scrollView
          view_collection.frame.size = CGSize(width: collectionViewWidth, height: collectionViewHeight)
        
        view_collection.backgroundColor = .gray
          scroll_view_zoom.contentSize = CGSize(width: collectionViewWidth, height: collectionViewHeight)

          // Đảm bảo scrollView có thể cuộn ngang
          scroll_view_zoom.isScrollEnabled = true
          scroll_view_zoom.showsHorizontalScrollIndicator = true
      }



     // ...
 














    
//    func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
////        layout.scrollDirection = .vertical
////        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 30, height: 30)
//        layout.minimumLineSpacing = 5
//        view_collection.collectionViewLayout = layout
//        view_collection.contentInset = UIEdgeInsets(top: 150, left: -5, bottom: 0, right: -5)
//        view_collection.translatesAutoresizingMaskIntoConstraints = false
//
//            view_collection.backgroundColor = ColorUtils.backgroudcolor()
//
//    }
    
//    func binđDataTableCollectionView(){
//        viewModel.dataArray.bind(to: view_collection.rx.items(cellIdentifier: "ItemChairCollectionViewCell", cellType: ItemChairCollectionViewCell.self)) { (index, element, cell) in
//
//
//
//
//            }.disposed(by: BookingChairViewController.rxbag)
//
//    }
    func binđDataTableCollectionView(){
             
        viewModel.listtable.bind(to: tableView.rx.items)
                     { [self] (table, index, employee) -> UITableViewCell in
                         let indexPath = IndexPath(row: index, section: 0)
                         switch index {
                         case 0:
                          let cell = self.tableView.dequeueReusableCell(withIdentifier: "headerTableViewCell", for: indexPath) as! headerTableViewCell
                               cell.viewModel = self.viewModel
                             return cell
                         case 1:
                           let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListChairBookiingTableViewCell", for: indexPath) as! ListChairBookiingTableViewCell
                                cell.viewModel = self.viewModel
                             
                             return cell
                         default:
                            let cell = self.tableView.dequeueReusableCell(withIdentifier: "headerTableViewCell", for: indexPath) as! headerTableViewCell
                                                     
                                                    
                            
                             return cell
                         }
             
             
                         }.disposed(by: rxbag)
                 
            }
}

extension BookingChairViewController: UITableViewDelegate {
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row {
            case 0:
                return 100
            case 1:
                return 800
            default:
                return 100
            }
    
        }
}
