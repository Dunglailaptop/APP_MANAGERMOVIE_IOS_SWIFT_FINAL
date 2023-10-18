//
//  DialogPopupInfoListInterestMovieViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/23/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DialogPopupInfoListInterestMovieViewController: UIViewController {
   
    @IBOutlet weak var poster: UIImageView!
    var name = ""
        var image = ""
   
    @IBOutlet weak var lbl_namemovie: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        resgiter()
        bindingtableviewcell()
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                                UIViewController.attemptRotationToDeviceOrientation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_namemovie.text = name
        poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: image)), placeholder: UIImage(named: "image_defauft_medium"))
    }

    var viewModel: ManagementInterestMoviesViewModel? = nil {
        didSet {
          
//            viewModel?.dataArrayInterestInfo.subscribe(onNext: {
//                [self] (response) in
//                self.tableView.reloadData()
//            })
        }
    }

    // Cho phép xoay cả hai hướng
             override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
                 return .landscape
             }


              override var shouldAutorotate: Bool {
                  return true
              }

              override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
                  return .landscapeRight
              }
    @IBAction func btn_access(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
extension DialogPopupInfoListInterestMovieViewController: UITableViewDelegate {
    func resgiter() {
        let cell = UINib(nibName: "DialogItemInterestMovieTableViewCell", bundle: .main)
        tableView.register(cell, forCellReuseIdentifier: "DialogItemInterestMovieTableViewCell")
        tableView.separatorStyle = .none
        tableView.rx.setDelegate(self)
    }
    func bindingtableviewcell() {
        viewModel!.dataArrayInterestInfo.bind(to: tableView.rx.items(cellIdentifier: "DialogItemInterestMovieTableViewCell", cellType: DialogItemInterestMovieTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.viewModel = self.viewModel
            cell.selectionStyle = .none
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
