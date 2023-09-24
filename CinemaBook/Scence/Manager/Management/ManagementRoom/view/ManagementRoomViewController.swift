//
//  ManagementRoomViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import BmoViewPager

class ManagementRoomViewController: UIViewController {
   var viewModel = ManagementRoomViewModel()
    var router = ManagementRoomRouter()
    var title_name = ["Phòng Đang Hoạt Động","Phòng Tạm Ngưng"]
    @IBOutlet weak var Collectionview: UICollectionView!
    @IBOutlet weak var viewPager: BmoViewPager!
    @IBOutlet weak var viewPagerBar: BmoViewPagerNavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
            self.viewPagerBar.viewPager = viewPager
            self.viewPagerBar.layer.masksToBounds = true
            self.viewPager.presentedPageIndex = 0
            self.viewPager.dataSource = self
            self.viewPager.delegate = self
            viewPagerBar.backgroundColor = ColorUtils.gray_6()
            viewPager.reloadData()
     
    }


   

}
extension ManagementRoomViewController: BmoViewPagerDelegate, BmoViewPagerDataSource{
   
    
   
    
    
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return self.title_name.count
    }
    
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        if(page == 0){
            let ListMovieShowNowRouters = BookingChairRouter().viewController as! BookingChairViewController
           
            return ListMovieShowNowRouters
        }else if(page == 1){
           let ListMovieShowNowRouters = BookingChairRouter().viewController as! BookingChairViewController
           
             return ListMovieShowNowRouters
        }else {
        let ListMovieShowNowRouters = BookingChairRouter().viewController as! BookingChairViewController
            
            return ListMovieShowNowRouters
        }
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor : ColorUtils.blackBackGroundColor()
        ]
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor : ColorUtils.blue_color()
        ]
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
        return self.title_name[page].uppercased()
    }

    
    func bmoViewPagerDataSourceNaviagtionBarItemSize(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGSize {
        switch page {
        case 0:
            return CGSize(width: 200, height: navigationBar.bounds.height)
        case 1:
            return CGSize(width: 200, height: navigationBar.bounds.height)
        default:
            return CGSize(width: 200, height: navigationBar.bounds.height)
        }
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
        let view = UIView()

        view.addBottomBorder()
        return view
    }
}

