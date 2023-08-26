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
 
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var view_collection: UICollectionView!
    
    @IBOutlet weak var view_of_collectionview: UIView!
    @IBOutlet weak var view_of_collection: UIView!
    
    @IBOutlet weak var scroll_view_zoom: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
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


   
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
}
extension BookingChairViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return view_collection
    }

}
