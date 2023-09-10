//
//  videoShortViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit


class videoShortViewController: BaseViewController {

 var viewModel = videoShortViewModel()
    var router = videoShortRouter()
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var view_of_collection: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        register()
        bindingCollectionViewCell()
        // Do any additional setup after loading the view.
    }


   

}
