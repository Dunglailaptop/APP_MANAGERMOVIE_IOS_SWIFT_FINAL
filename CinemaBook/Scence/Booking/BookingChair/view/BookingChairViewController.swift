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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
      resgisterCollection()
        binđDataTableCollectionView()
        // Do any additional setup after loading the view.
    }


   
}
