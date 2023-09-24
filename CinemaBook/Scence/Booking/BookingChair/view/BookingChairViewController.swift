//
//  BookingChairViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class BookingChairViewController: BaseViewController {

    var viewModel = BookingChairViewModel()
    var router = BookingChairRouter()
    
    var currentScale: CGFloat = 1.0
    var safeAreaInsets: UIEdgeInsets = .zero
     var originalCollectionViewSize: CGSize = .zero
    var type = 0
    var idcinema = 0
    var idroom = 0
    var idinterest = 0
 //view hidden
    @IBOutlet weak var view_height_info: NSLayoutConstraint!
   
    @IBOutlet weak var view_info_room: UIView!
    
    @IBOutlet weak var view_payment: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var view_collection: UICollectionView!
    
    @IBOutlet weak var view_of_collectionview: UIView!
    @IBOutlet weak var view_of_collection: UIView!
    
    @IBOutlet weak var scroll_view_zoom: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        view_of_collectionview.backgroundColor = ColorUtils.backgroudcolor()
        scroll_view_zoom.delegate = self
//        originalCollectionViewSize = view_collection.frame.size
//        view_collection.contentSize = CGSize(width: 100, height: 100)
//        NSLayoutConstraint.activate([
//            view_collection.topAnchor.constraint(equalTo: scroll_view_zoom.topAnchor, constant: 0),
//                 view_collection.leadingAnchor.constraint(equalTo: scroll_view_zoom.leadingAnchor,constant: 0),
//                 view_collection.trailingAnchor.constraint(equalTo: scroll_view_zoom.trailingAnchor,constant: 0),
//                 view_collection.bottomAnchor.constraint(equalTo: scroll_view_zoom.bottomAnchor,constant: 0)
//             ])
        
      resgisterCollection()
        binđDataTableCollectionView()
       
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            var data = viewModel.pagition.value
            data.idroom = idroom
            data.idinterest = idinterest
            data.idcinema = idcinema
            viewModel.pagition.accept(data)
        if type == 1{
            self.view_info_room.isHidden = true
            self.view_payment.isHidden = true
            self.view_height_info.constant = 0
            getListchairRoom()
        }else {
            getListchair()
        }
      
        
    }
   
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
}
extension BookingChairViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return view_collection
    }

}
