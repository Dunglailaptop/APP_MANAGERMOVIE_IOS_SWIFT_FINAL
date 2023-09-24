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
        register()
        bindingCollectionCell()
        registerCategory()
        bindingCollectionCategory()
        viewModel.bind(view: self,router: router)
        
        view1 = BookingChairViewController(nibName: "BookingChairViewController", bundle: .main) as!  BookingChairViewController
             view1.type = 1
             view1.idroom = 1
             addTopCustomViewController(view1, addTopCustom: 170)

            view2 = ManagementCategoryChairViewController(nibName: "ManagementCategoryChairViewController", bundle: .main) as! ManagementCategoryChairViewController
        view2.viewModel = viewModel
         room_working()
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
        getListCategoryChair()
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
    
}
//extension ManagementRoomViewController: BmoViewPagerDelegate, BmoViewPagerDataSource{
//
//
//
//
//
//    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
//        return self.title_name.count
//    }
//
//    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
//        if(page == 0){
//            let ListMovieShowNowRouters = BookingChairRouter().viewController as! BookingChairViewController
//           ListMovieShowNowRouters.type = 1
//
//            return ListMovieShowNowRouters
//        }else if(page == 1){
//           let ListMovieShowNowRouters = BookingChairRouter().viewController as! BookingChairViewController
//          ListMovieShowNowRouters.type = 1
//
//             return ListMovieShowNowRouters
//        }else {
//        let ListMovieShowNowRouters = BookingChairRouter().viewController as! BookingChairViewController
//            ListMovieShowNowRouters.type = 1
//
//            return ListMovieShowNowRouters
//        }
//    }
//
//    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
//        return [
//            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12.0),
//            NSAttributedString.Key.foregroundColor : ColorUtils.blackBackGroundColor()
//        ]
//    }
//
//    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
//        return [
//            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12.0),
//            NSAttributedString.Key.foregroundColor : ColorUtils.blue_color()
//        ]
//    }
//
//    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
//        return self.title_name[page].uppercased()
//    }
//
//
//    func bmoViewPagerDataSourceNaviagtionBarItemSize(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGSize {
//        switch page {
//        case 0:
//            return CGSize(width: 200, height: navigationBar.bounds.height)
//        case 1:
//            return CGSize(width: 200, height: navigationBar.bounds.height)
//        default:
//            return CGSize(width: 200, height: navigationBar.bounds.height)
//        }
//    }
//
//    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
//        let view = UIView()
//
//        view.addBottomBorder()
//        return view
//    }
//
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return viewPager
//    }
//}
//
