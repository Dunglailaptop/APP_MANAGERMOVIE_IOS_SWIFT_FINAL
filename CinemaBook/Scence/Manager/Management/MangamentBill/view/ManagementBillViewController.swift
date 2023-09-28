//
//  ManagementBillViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import BmoViewPager

class ManagementBillViewController: UIViewController {

    var title_name = ["HÓA ĐƠN VÉ","HÓA DƠN SẢN PHẨM","HÓA HOÀN TẤT","HÓA ĐƠN CHỜ XÁC NHẬN"]
    
    @IBOutlet weak var bmoViewBar: BmoViewPagerNavigationBar!
    
    @IBOutlet weak var bmoViewPager: BmoViewPager!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bmoViewBar.viewPager = bmoViewPager
             self.bmoViewBar.layer.masksToBounds = true
             self.bmoViewPager.presentedPageIndex = 0
             self.bmoViewPager.dataSource = self
             self.bmoViewPager.delegate = self
        bmoViewBar.backgroundColor = ColorUtils.white()
    }


  

}
extension ManagementBillViewController: BmoViewPagerDelegate, BmoViewPagerDataSource{
   
    
   
    
    
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return self.title_name.count
    }
    
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        if(page == 0){
            let ListMovieShowNowRouters = ManagementBillTicketViewController()
         
            return ListMovieShowNowRouters
        }else if(page == 1){
          let ListMovieShowNowRouters = ManagementBillTicketViewController()
                   
                      return ListMovieShowNowRouters
        }else {
       let ListMovieShowNowRouters = ManagementBillTicketViewController()
                
                   return ListMovieShowNowRouters
        }
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14.0),
            NSAttributedString.Key.foregroundColor : ColorUtils.blackBackGroundColor()
        ]
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14.0),
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
