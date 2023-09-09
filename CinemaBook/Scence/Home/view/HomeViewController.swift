//
//  HomeViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import LNICoverFlowLayout

class HomeViewController: BaseViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
   var viewModel = HomeViewModel()
    var router = HomeRouter()
    @IBOutlet weak var avatar: UIImageView!
    
  
    @IBOutlet weak var lbl_movie_coming: UILabel!
    @IBOutlet weak var view_movie_coming: UIView!
    @IBOutlet weak var lbl_movie_now: UILabel!
    @IBOutlet weak var view_movienow: UIView!
    @IBOutlet weak var collection_view: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        Register()
        bindingtable()
        setup()
     
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
               
                 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.getListMovieShowBanner()
       
    }
    
    @IBAction func btn_movienow(_ sender: Any) {
        view_movie_coming.backgroundColor = .white
        lbl_movie_coming.textColor = .blue
        view_movienow.backgroundColor = .blue
        lbl_movie_now.textColor = .white
        var data = viewModel.pagigation.value
        data.status = 1
        viewModel.pagigation.accept(data)
        self.getListMovieShowBanner()
    }
    
    @IBAction func btn_moviecoming(_ sender: Any) {
        view_movienow.backgroundColor = .white
        lbl_movie_now.textColor = .blue
        view_movie_coming.backgroundColor = .blue
        lbl_movie_coming.textColor = .white
        var data = viewModel.pagigation.value
        data.status = 0
        viewModel.pagigation.accept(data)
        self.getListMovieShowBanner()
    }
}
