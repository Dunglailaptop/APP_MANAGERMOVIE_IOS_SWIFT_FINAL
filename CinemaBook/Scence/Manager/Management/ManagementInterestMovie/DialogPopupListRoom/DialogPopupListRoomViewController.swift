//
//  DialogPopupListRoomViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/18/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class DialogPopupListRoomViewController: UIViewController {

    @IBOutlet weak var lbl_time_reset: UILabel!
    @IBOutlet weak var lbl_date_interest: UILabel!
  
    @IBOutlet weak var lbl_name_room: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
  
    var delegate: DialogListPopupInterestRoom?
    var Movies = [Movie]()
//    @IBOutlet weak var tableView: UITableView!
    var date = ""
    var idroom = 0
    var nameroom = ""
    var timeReset = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        bindingtable()
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_name_room.text = nameroom
        lbl_date_interest.text = date
        lbl_time_reset.text = String(timeReset)
    }
    
    var viewModel : ManagementInterestMoviesViewModel? = nil {
        didSet {
           
          
        }
    }
    

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_access(_ sender: Any) {
       
        delegate?.callbackDialogListRoom(idroom: idroom, date: date)

    }
}

extension DialogPopupListRoomViewController {
    func register() {
        let collectioncell = UINib(nibName: "ItemDialogPopUpDetailInterestCollectionViewCell", bundle: .main)
        collectionview.register(collectioncell, forCellWithReuseIdentifier: "ItemDialogPopUpDetailInterestCollectionViewCell")
        setupCollectionView()
    }
    
    func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 200, height: 80)
            layout.minimumLineSpacing = 5
            collectionview.collectionViewLayout = layout
            collectionview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            collectionview.translatesAutoresizingMaskIntoConstraints = false
            }
    
    func bindingtable() {
        viewModel!.dataArrayMovie.bind(to: collectionview.rx.items(cellIdentifier: "ItemDialogPopUpDetailInterestCollectionViewCell", cellType: ItemDialogPopUpDetailInterestCollectionViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
