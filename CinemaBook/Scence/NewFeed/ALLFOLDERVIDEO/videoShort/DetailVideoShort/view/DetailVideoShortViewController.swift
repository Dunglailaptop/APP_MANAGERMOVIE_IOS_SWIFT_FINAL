//
//  DetailVideoShortViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import FSPagerView

class DetailVideoShortViewController: UIViewController {

    var viewModel = DetailVideoShortViewModel()
    var router = DetailVideoShortRouter()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
         resgister()
        bindingCollectionViewCell()
    }

    
   

}
