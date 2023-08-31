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
import BmoViewPager

class BookingTicketViewController: BaseViewController  {

  var viewModel = BookingViewModel()
    var router = BookingRouter()
 
    var title_name = ["Phim đang chiếu","Phim sắp chiếu"]
    
    @IBOutlet weak var viewPager: BmoViewPager!
    @IBOutlet weak var _navigationbar: BmoViewPagerNavigationBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         viewModel.bind(view: self, router: router)
        self._navigationbar.viewPager = viewPager
        self._navigationbar.layer.masksToBounds = true
        self.viewPager.presentedPageIndex = 0
        self.viewPager.dataSource = self
        self.viewPager.delegate = self
        _navigationbar.backgroundColor = ColorUtils.gray_6()
//        resgisterCollection()
//        binđDataTableCollectionView()
//
     
        viewPager.reloadData()
        // Do any additional setup after loading the view.
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        getListmovie()
    }
 
    
   

}
extension BookingTicketViewController: BmoViewPagerDelegate, BmoViewPagerDataSource{
   
    
   
    
    
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return self.title_name.count
    }
    
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        if(page == 0){
            let pendingOrderManagementViewController = ListMovieShowNowRouter().viewController as! ListMovieShowNowViewController
            return pendingOrderManagementViewController
        }else if(page == 1){
             let pendingOrderManagementViewController = HomeViewController()
                      return pendingOrderManagementViewController
        }else if(page == 2){
             let pendingOrderManagementViewController = HomeViewController()
                      return pendingOrderManagementViewController
        }else {
            let pendingOrderManagementViewController = HomeViewController()
                      return pendingOrderManagementViewController
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
            NSAttributedString.Key.foregroundColor : ColorUtils.red_color()
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
