import UIKit

extension MenuViewController
{
    func setupNavigationBar() {
        let tabBarvc = UITabBarController()
        
        let view1 = HomeViewController()
        let view2 = TicketViewController()
        let view3 = SalesViewController()
        let view4 = NewFeedViewController()
        let view5 = AccountViewController()
        
        view1.title = "Trang chủ"
        view2.title = "Vé xem"
        view3.title = "Sự kiện"
        view4.title = "Thông báo"
        view5.title = "Tài khoản"
        
        tabBarvc.setViewControllers([view5], animated: false)
        
        guard let item = tabBarvc.tabBar.items else {
            return
        }
        let imagex = ["icon_house","icon_ticket","icon_bell","icon_heart","user"]
        for it in 0..<item.count {
            item[it].badgeValue = "1"
            item[it].image = UIImage(named: imagex[it])
        }
        tabBarvc.modalPresentationStyle = .fullScreen
        UITabBar.appearance().tintColor = UIColor.gray // Set the tint color for selected items
        UITabBar.appearance().unselectedItemTintColor = UIColor.white // Set the tint color for unselected items
        UITabBar.appearance().barTintColor = UIColor.white // Set the background color of the tab bar
        
        let redValue: CGFloat = 33.0 / 255.0 // Replace with your desired red value (0-255)
        let greenValue: CGFloat = 36.0 / 255.0 // Replace with your desired green value (0-255)
        let blueValue: CGFloat = 44.0 / 255.0 // Replace with your desired blue value (0-255)
        
        let tabBarColor = UIColor(
            red: redValue,
            green: greenValue,
            blue: blueValue,
            alpha: 1.0 // The alpha value is set to 1.0 (fully opaque) by default
        )
        
        tabBarvc.tabBar.barTintColor = tabBarColor
        tabBarvc.tabBar.layer.cornerRadius = 20 
        tabBarvc.tabBar.layer.masksToBounds = true
        present(tabBarvc, animated: true)
    }
}
