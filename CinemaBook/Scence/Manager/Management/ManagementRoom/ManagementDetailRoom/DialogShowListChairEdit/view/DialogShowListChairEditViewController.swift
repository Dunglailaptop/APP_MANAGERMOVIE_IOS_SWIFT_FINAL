//
//  DialogShowListChairEditViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 24/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import iOSDropDown
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper

class DialogShowListChairEditViewController: UIViewController {

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var btn_drop_show_down: UIButton!
    @IBOutlet weak var txt_drop_down: DropDown!
    var listchair = [chair]()
    override func viewDidLoad() {
        super.viewDidLoad()
        resgiter()
        bindingtable()
        getListCategory()
        btn_drop_show_down.rx.tap.asDriver().drive(onNext: { [self] in
            self.txt_drop_down.showList()
        })
      
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_access(_ sender: Any) {
        
    }
    
    var viewModel: ManagementDetailRoomViewModel? = nil {
        didSet {
           
        }
    }
    
}
extension DialogShowListChairEditViewController {
    func getListCategory(){
        viewModel?.getListCategoryChair().subscribe(onNext: {
            (response) in
            dLog(response)
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<CategoryChair>().mapArray(JSONObject: response.data) {
                    self.viewModel?.dataArrayCategoryChair.accept(data)
                    dLog(data)
                    self.txt_drop_down.optionArray = data.map{$0.namecategorychair}
                    self.txt_drop_down.optionIds = data.map{$0.idcategorychair}
                }
            }
        })
    }
    
    func resgiter(){
        let viewcell = UINib(nibName: "ManagementDetailRoomItemCollectionViewCell", bundle: .main)
        collectionview.register(viewcell, forCellWithReuseIdentifier: "ManagementDetailRoomItemCollectionViewCell")
        setupCollectionView()
    }
    func setupCollectionView() {
                 let layout = UICollectionViewFlowLayout()
                 layout.scrollDirection = .horizontal
                 layout.itemSize = CGSize(width: 100, height: 30)
                 layout.minimumLineSpacing = 5
                 collectionview.collectionViewLayout = layout
                 collectionview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                 collectionview.translatesAutoresizingMaskIntoConstraints = false
             }
    
    func bindingtable(){
        viewModel?.dataArrayChairChoose.bind(to: collectionview.rx.items(cellIdentifier: "ManagementDetailRoomItemCollectionViewCell", cellType: ManagementDetailRoomItemCollectionViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
