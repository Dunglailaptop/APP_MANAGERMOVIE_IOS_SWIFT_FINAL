//
//  BookingChairViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class BookingChairViewController: UIViewController {

    var viewModel = BookingChairViewModel()
    var router = BookingChairRouter()
    
    var currentScale: CGFloat = 1.0
    var safeAreaInsets: UIEdgeInsets = .zero
 
    @IBOutlet weak var view_collection: UICollectionView!
    
    
    @IBOutlet weak var scroll_view_zoom: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        scroll_view_zoom.delegate = self
        
        
        NSLayoutConstraint.activate([
                 view_collection.topAnchor.constraint(equalTo: scroll_view_zoom.topAnchor, constant: 0),
                 view_collection.leadingAnchor.constraint(equalTo: scroll_view_zoom.leadingAnchor),
                 view_collection.trailingAnchor.constraint(equalTo: scroll_view_zoom.trailingAnchor),
                 view_collection.bottomAnchor.constraint(equalTo: scroll_view_zoom.bottomAnchor)
             ])
        
      resgisterCollection()
        binđDataTableCollectionView()
        // Do any additional setup after loading the view.
    }


   
}
extension BookingChairViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return view_collection
    }
    
}
