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
import JonAlert

extension BookingChairViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func resgiter() {
        let cellviewitem = UINib(nibName: "ItemBillWithRoomCollectionViewCell", bundle: .main)
        collection_view_listbill.register(cellviewitem, forCellWithReuseIdentifier: "ItemBillWithRoomCollectionViewCell")
        collection_view_listbill.delegate = self
        collection_view_listbill.dataSource = self
//        collection_view_listbill.rx.modelSelected(billinfowithroom.self).subscribe(onNext: {
//            element in
//            self.viewModel.makeToDetailBillViewController(idbill: element.idbill)
//        })
        setupCollection()
    }
    
    func setupCollection() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 80)
        collection_view_listbill.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataArrayBillListWithRoom.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemBillWithRoomCollectionViewCell", for: indexPath) as!  ItemBillWithRoomCollectionViewCell
        var data = viewModel.dataArrayBillListWithRoom.value[indexPath.row].chairess
        var allchair = ""
        cell.lbl_id_bill.text = "Mã BILL: " + String(viewModel.dataArrayBillListWithRoom.value[indexPath.row].idbill)
        data.enumerated().forEach{ (index,value) in
            allchair += "," + value.rowChar
        }
        cell.lbl_numberchair.text = "Ghế: " + allchair
        cell.lbl_totalamount.text = Utils.stringVietnameseFormatWithNumber(amount: viewModel.dataArrayBillListWithRoom.value[indexPath.row].totalamount)
        cell.idbill = viewModel.dataArrayBillListWithRoom.value[indexPath.row].idbill
        cell.viewModel = viewModel
        return cell
    }
  
    func getlistbillRoom() {
        viewModel.getlistbillroom().subscribe(onNext: {
            [self]   (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<billinfowithroom>().mapArray(JSONObject: response.data) {
                    viewModel.dataArrayBillListWithRoom.accept(data)
                    collection_view_listbill.reloadData()
                    dLog(data)
                }
            }else {
                
            }
        })
    }
}
//CALL API
extension BookingChairViewController {
    func getListchair() {
        viewModel.getListchair().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<chair>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                    dLog(response.data)
                    var dataget = self.viewModel.dataArray.value
                    dataget.enumerated().forEach{(index,value) in
                        if value.bill != 0 {
                            dataget[index].isSelected = BILL
                        }
                    }
                    self.viewModel.dataArray.accept(dataget)
                    self.getInfoInterestMovie()
                   
                }
            }
            }).disposed(by: rxbag)
    }
    func getListchairRoom() {
        viewModel.getListchairRoom().subscribe(onNext: {
            (response) in
            dLog(response.data)
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<chair>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                }
            }
            }).disposed(by: rxbag)
    }
    
    func getInfoInterestMovie() {
        viewModel.getinfoInterestMovie().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<InfoInterestMovie>().map(JSONObject: response.data) {
                    self.viewModel.infoInterestMovie.accept(data)
                     self.setup()
                }
            }
        })
    }
    func setup() {
        var dataInfo = viewModel.infoInterestMovie.value
        var starttimeconvert = dataInfo.startstime.components(separatedBy: "T")
        var dateshow = dataInfo.dateshow.components(separatedBy: "T")
        lbl_info_interest.text = dataInfo.nameroom + "," + dateshow[0] + "," + starttimeconvert[1]
        lbl_name_cinema.text = dataInfo.namecinema
        lbl_namemovie.text = dataInfo.namemovie
        lbl_listbill_namemovie.text = namemovie
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
                             cell.viewModel = self.viewModel
                                                    
                            
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
