
//
//  CustomTabItem.swift
//  CustomTabBarExample
//
//  Created by Jędrzej Chołuj on 18/12/2021.
//

import UIKit

enum CustomTabItem: String, CaseIterable {
    case Home
    case Ticket
    case newFeed
    //    case fee
    case NotificationApp
    case SettingAccount
}

extension CustomTabItem {
    var viewController: UIViewController {
        switch self {
        case .Home:
            dLog(ManageCacheObject.getCurrentUserInfo().idrole)
            if ManageCacheObject.getCurrentUserInfo().idrole == 2 {
                let view = HomeReportViewController(nibName: "HomeReportViewController", bundle: Bundle.main)
                return view
            }else  {
                let view = HomeViewController(nibName: "HomeViewController", bundle: Bundle.main)
                return view
            }
            
        case .Ticket:
            if ManageCacheObject.getCurrentUserInfo().idrole == 2 {
                let view = ManagementViewController(nibName: "ManagementViewController", bundle: Bundle.main)
                return view
            }else {
                let view = BookingTicketViewController(nibName: "BookingTicketViewController", bundle: Bundle.main)
                return view
            }
           
        case .newFeed:
            let view = NewFeedViewController(nibName: "NewFeedViewController", bundle: Bundle.main)
            
            return view
            
            //           case .fee:
            //               let view = FeeViewController(nibName: "FeeViewController", bundle: Bundle.main)
            //
            //               return view
            
        case .NotificationApp:
           
                let view = NotifcationMessageViewController(nibName: "NotifcationMessageViewController", bundle: Bundle.main)
                
                return view
            
        case .SettingAccount:
            let view = AccountViewController(nibName: "AccountViewController", bundle: Bundle.main)
            
            return view
        }
    }
    
    
    var icon: UIImage? {
        switch self {
        case .Home:
            if ManageCacheObject.getCurrentUserInfo().idrole == 2 {
                    return UIImage(named: "icon-report")?.withTintColor(ColorUtils.gray_400(), alpha: CGFloat(1))
            }else {
                    return UIImage(named: "icon-homes")?.withTintColor(ColorUtils.gray_400(), alpha: CGFloat(1))
            }
        
        case .Ticket:
            if ManageCacheObject.getCurrentUserInfo().idrole == 2 {
                 return UIImage(named: "icon-manager")?.withTintColor(ColorUtils.gray_400(), alpha: CGFloat(1))
            }else {
                 return UIImage(named: "icon-tickets")?.withTintColor(ColorUtils.gray_400(), alpha: CGFloat(1))
            }
           
        case .newFeed:
            return UIImage(named: "icon-newfees")?.withTintColor(ColorUtils.gray_400(), alpha: CGFloat(1))
            
            //           case .fee:
            //               return UIImage(named: "icon-fee-tabbar")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
            
        case .NotificationApp:
            
           
                return UIImage(named: "icon-bell")?.withTintColor(ColorUtils.gray_400(), alpha: CGFloat(1))
            
            
        case .SettingAccount:
            return UIImage(named: "icon-user")?.withTintColor(ColorUtils.gray_400(), alpha: CGFloat(1))
        }
    }
    
    
    var selectedIcon: UIImage? {
        switch self {
        case .Home:
            if ManageCacheObject.getCurrentUserInfo().idrole == 2 {
                    return UIImage(named: "icon-report")?.withTintColor(ColorUtils.buttonGreen(), alpha: CGFloat(1))
            }else {
                    return UIImage(named: "icon-homes")?.withTintColor(ColorUtils.buttonGreen(), alpha: CGFloat(1))
            }
        
            
        case .Ticket:
            if ManageCacheObject.getCurrentUserInfo().idrole == 2 {
                 return UIImage(named: "icon-manager")?.withTintColor(ColorUtils.buttonGreen(), alpha: CGFloat(1))
            }else {
                 return UIImage(named: "icon-tickets")?.withTintColor(ColorUtils.buttonGreen(), alpha: CGFloat(1))
            }
           
        case .newFeed:
            return UIImage(named: "icon-newfees")?.withTintColor(ColorUtils.buttonGreen(), alpha: CGFloat(1))
       
            //           case .fee:
            //               return UIImage(named: "icon-fee-tabbar")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
        case .NotificationApp:
            return UIImage(named: "icon-bell")?.withTintColor(ColorUtils.buttonGreen(), alpha: CGFloat(1))
           
        case .SettingAccount:
            return UIImage(named: "icon-user")?.withTintColor(ColorUtils.buttonGreen(), alpha: CGFloat(1))
        }
    }
    
    
    var name: String {
        if(self.rawValue.capitalized == "Home"){
            return "Trang chủ"
        }else if(self.rawValue.capitalized == "Ticket"){
            return "Đặt vé"
        }else if(self.rawValue.capitalized == "Newfeed"){
            return "Tương tác"
            //            }else if(self.rawValue.capitalized == "Fee"){
            //                return "Chi phí"
            //            }
        } else if(self.rawValue.capitalized == "Notificationapp"){
            
                return "Thông báo"
         
            
            
            
        }else if(self.rawValue.capitalized == "Settingaccount"){
            return "Cài đặt"
        }
        return self.rawValue.capitalized
    }
}

