//
//  DetailProductComboViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 12/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper
import RxCocoa
import RxRelay
import RxSwift

class DetailProductComboViewController: UIViewController {

    @IBOutlet weak var lbl_number_cart: UILabel!
    @IBOutlet weak var image_food: UIImageView!
    @IBOutlet weak var lbl_description_food: UITextView!
    @IBOutlet weak var lbl_name_food: UILabel!
    @IBOutlet weak var lbl_price_food: UILabel!
    var viewModel = DetailProductViewModel()
    var router = DetailProductRouter()
    var foodcombo = FoodCombo()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name ("GETDATESATRING"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any] {
                // Access the loginResponse dictionary here
                if let reportType = userInfo["listcart"] as? [String: Any] {
                    let foodcombo = reportType["foodcombo"] as? FoodCombo
                    let food = reportType["food"] as? Food
                    let foodwater = reportType["foodwater"] as? Food
                    lbl_number_cart.text = String(ManageCacheObject.getCartInfo().count)
                    dLog(ManageCacheObject.getCartInfo().count)
                    ManageCacheObject.getCartInfo().enumerated().forEach{(index,value) in
                        dLog(value)
                    }
                  dLog(foodcombo)
                }
            }
    }
    
    func setup(){
        lbl_description_food.text = foodcombo.descriptions
        lbl_name_food.text = foodcombo.nametittle
        lbl_price_food.text = Utils.stringVietnameseFormatWithNumber(amount: foodcombo.priceCombo)
        image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: foodcombo.picture)), placeholder: UIImage(named: "image_defauft_medium"))
        viewModel.dataDetailFoodCombo.accept(foodcombo)
        lbl_number_cart.text = String(ManageCacheObject.getCartInfo().count)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListfood()
        
        setup()
        
    }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewOrderProduct()
    }
    
    @IBAction func btn_showPopUpChooseListFoodCombo(_ sender: Any) {
        presenDialog(foodcombos: foodcombo)
    }
    
}
extension DetailProductComboViewController {
    func presenDialog(foodcombos: FoodCombo) {
        let DialogPopUpShowListFoodChooseViewControllers = DialogPopUpShowListFoodChooseViewController()
        DialogPopUpShowListFoodChooseViewControllers.viewModel = viewModel
        DialogPopUpShowListFoodChooseViewControllers.dataFoodDetail = foodcombos
        DialogPopUpShowListFoodChooseViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
     
        let nav = UINavigationController(rootViewController: DialogPopUpShowListFoodChooseViewControllers)
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
extension DetailProductComboViewController {
    func getListfood() {
        viewModel.getListFood().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Food>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArrayfood.accept(data)
                    dLog(self.viewModel.dataArrayfood.value)
                    self.getListfoodwater()
                }
            }
        })
    }
    func getListfoodwater() {
        viewModel.getListFoodwater().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Food>().mapArray(JSONObject: response.data) {
                  
                    self.viewModel.dataArrayFoodWater.accept(data)
                    var datagetquantiy = self.viewModel.dataArrayFoodWater.value
                    datagetquantiy.enumerated().forEach{
                        (index,value) in
                        datagetquantiy[index].quantityRealTime = 1
                    }
                    self.viewModel.dataArrayFoodWater.accept(datagetquantiy)
                    dLog(self.viewModel.dataArrayFoodWater.value)
                }
            }
        })
    }
}
