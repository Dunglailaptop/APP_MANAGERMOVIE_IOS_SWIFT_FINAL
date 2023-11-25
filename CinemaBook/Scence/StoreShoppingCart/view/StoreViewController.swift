//
//  StoreViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var btn_makePopToViewController: UIButton!
    @IBOutlet weak var icon_back: UIImageView!
    @IBOutlet weak var lbl_number_cart: UILabel!
    var view1 = OrderProductViewController()
    var viewModel = StoreViewModel()
    var router = StoreRouter()
    var type = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
         setupViewOrderProductViewController()
        if type == 1 {
            btn_makePopToViewController.isUserInteractionEnabled = false
            icon_back.isHidden = true
        }else {
            btn_makePopToViewController.isUserInteractionEnabled = true
            icon_back.isHidden = false
        }
        // Do any additional setup after loading the view.
    }

    func setupViewOrderProductViewController() {
        view1.type = 1
        addTopCustomViewController(view1, addTopCustom: 120)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name ("GETDATESATRING"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_number_cart.text = String(ManageCacheObject.getCartInfo().reduce(0) { $0 + $1.quantityRealtime })
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any] {
                // Access the loginResponse dictionary here
                if let reportType = userInfo["listcart"] as? [String: Any] {
                    let foodcombo = reportType["foodcombo"] as? FoodCombo
                    let food = reportType["food"] as? Food
                    let foodwater = reportType["foodwater"] as? Food
                    var countnumber = 0
                  
                    lbl_number_cart.text = String(ManageCacheObject.getCartInfo().reduce(0) { $0 + $1.quantityRealtime })
//                    dLog(ManageCacheObject.getCartInfo().count)
                  dLog(foodcombo)
                }
            }
    }

    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    
    @IBAction func btn_showPopUPChooseCinema(_ sender: Any) {
        presentDialog()
    }
    
    @IBAction func btn_makeToCartViewController(_ sender: Any) {
        viewModel.makePopStoreViewController()
    }
    
    
}
extension StoreViewController {
    func presentDialog() {
        let DIalogPopUpShowListViewControllers = DIalogPopUpShowListViewController()
        
        DIalogPopUpShowListViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
//        DialogConfrimShowInfoViewController.Delegate = self
        DIalogPopUpShowListViewControllers.viewModel = viewModel
        
        
        let nav = UINavigationController(rootViewController: DIalogPopUpShowListViewControllers)
        // 1
        nav.modalPresentationStyle = .overCurrentContext

        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                
                // 3
                sheet.detents = [.large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4

        present(nav, animated: true, completion: nil)
    }
}
