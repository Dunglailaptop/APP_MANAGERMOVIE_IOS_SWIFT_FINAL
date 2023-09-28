//
//  ManagementRoomViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import BmoViewPager

class ManagementRoomViewController: BaseViewController {
   var viewModel = ManagementRoomViewModel()
    var router = ManagementRoomRouter()
    var view1 = BookingChairViewController()
    var view2 = ManagementCategoryChairViewController()
    var delegate: CallBackCallApiLoadListChair?
    var title_name = ["Phòng Đang Hoạt Động","Phòng Tạm Ngưng"]
    @IBOutlet weak var Collectionview: UICollectionView!
   
    @IBOutlet weak var collectionView_category_chair: UICollectionView!
    @IBOutlet weak var height_viewListroom: NSLayoutConstraint!
    @IBOutlet weak var height_viewListCategory: NSLayoutConstraint!
    @IBOutlet weak var view_listCategoryChair: UIView!
    @IBOutlet weak var view_listroom: UIView!
    @IBOutlet weak var view_line_notworking: UIView!
    @IBOutlet weak var view_line_working: UIView!
    @IBOutlet weak var lbl_room_status_notworking: UILabel!
    @IBOutlet weak var lbl_room_status_working: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        register()
        bindingCollectionCell()
        registerCategory()
        bindingCollectionCategory()
        registerViewController()
        
      
    }


    @IBAction func btn_room_working(_ sender: Any) {
      room_working()
    }
    
    @IBAction func btn_room_notworking(_ sender: Any) {
      room_notworking()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListRoom()
     
    }
    
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    func room_working() {
        view_line_working.backgroundColor = .systemBlue
        lbl_room_status_working.textColor = .systemBlue
        view_line_notworking.backgroundColor = .clear
        lbl_room_status_notworking.textColor = .black
        view_listroom.isHidden = false
        view_listCategoryChair.isHidden = false
        height_viewListroom.constant = 0
        height_viewListCategory.constant = 50
        height_viewListroom.constant = 40
        addTopCustomViewController(view1, addTopCustom: 170)
        view2.remove()

       
        
    }
    func room_notworking() {
        view_line_working.backgroundColor = .clear
        lbl_room_status_working.textColor = .black
        view_line_notworking.backgroundColor = .systemBlue
        lbl_room_status_notworking.textColor = .systemBlue
        view_listroom.isHidden = true
        view_listCategoryChair.isHidden = true
        height_viewListCategory.constant = 0
               height_viewListroom.constant = 0
        addTopCustomViewController(view2, addTopCustom: 90)
        view1.remove()
     
       
    }
    
    func registerViewController() {
        
        view1 = BookingChairViewController(nibName: "BookingChairViewController", bundle: .main) as!  BookingChairViewController
        view1.type = 1
        view1.idroom = 1
        addTopCustomViewController(view1, addTopCustom: 170)

        view2 = ManagementCategoryChairViewController(nibName: "ManagementCategoryChairViewController", bundle: .main) as! ManagementCategoryChairViewController
        view2.viewModel = viewModel
        room_working()
    }
    
    @IBAction func btn_makeToCreateRoomViewController(_ sender: Any) {
        viewModel.makeCreateRoomViewController()
    }
}
