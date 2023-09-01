//
//  NewFeedViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import BmoViewPager

class NewFeedViewController: BaseViewController {

    
    @IBOutlet weak var BmoNavigation: BmoViewPagerNavigationBar!
    
    @IBOutlet weak var BmoViewplayer: BmoViewPager!
    
    var title_name = ["Tất cả","Phim","Video short","Trailler"]
    override func viewDidLoad() {
        super.viewDidLoad()
         self.BmoNavigation.viewPager = BmoViewplayer
                self.BmoNavigation.layer.masksToBounds = true
                self.BmoViewplayer.presentedPageIndex = 0
                self.BmoViewplayer.dataSource = self
                self.BmoViewplayer.delegate = self
                BmoNavigation.backgroundColor = ColorUtils.gray_6()
        //        resgisterCollection()
        //        binđDataTableCollectionView()
        //
             
                BmoViewplayer.reloadData()
                // Do any additional setup after loading the view.
    
    }

     
}
extension NewFeedViewController: BmoViewPagerDataSource,BmoViewPagerDelegate {
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
           return self.title_name.count
       }
       
       func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
           if(page == 0){
            let pendingOrderManagementViewController = AllVideoandMovieViewController()
               return pendingOrderManagementViewController
           }else if(page == 1){
                let pendingOrderManagementViewController = MovieRouter().viewController
                         return pendingOrderManagementViewController
           }else if(page == 2){
                let pendingOrderManagementViewController = videoShortViewController()
                         return pendingOrderManagementViewController
           }else if(page == 3){
            let pendingOrderManagementViewController = TraillerViewController()
                     return pendingOrderManagementViewController
           }else {
               let pendingOrderManagementViewController = TraillerViewController()
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

           // Set the corner radius
              view.layer.cornerRadius = 8.0 // Adjust the value to your desired corner radius
              
              // Add spacing around the view by adjusting its frame
              let spacing: CGFloat = 10.0 // Adjust the value to your desired spacing
              view.frame = CGRect(x: spacing, y: 0, width: navigationBar.bounds.width - (2 * spacing), height: navigationBar.bounds.height)
              
              // Set a background color if needed
        view.backgroundColor = ColorUtils.blue()
           return view
       }
}
