//
//  BookingTicketViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/13/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class BookingTicketViewController: BaseViewController  {

  var viewModel = BookingViewModel()
    var router = BookingRouter()
 
    @IBOutlet weak var collectionviewcell: UICollectionView!
    
    @IBOutlet weak var viewCollection: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         viewModel.bind(view: self, router: router)
   
        resgisterCollection()
        binđDataTableCollectionView()
    
     
    
        // Do any additional setup after loading the view.
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListmovie()
    }
 
    
   

}
