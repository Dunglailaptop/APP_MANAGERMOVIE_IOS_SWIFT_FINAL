//
//  MangamentProductViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class MangamentProductViewController: UIViewController {

   
    @IBOutlet weak var view_food: UIView!
    @IBOutlet weak var view_foodcombo: UIView!
    @IBOutlet weak var lbl_name_foodcombo: UILabel!
    @IBOutlet weak var lbl_name_listfood: UILabel!
    var viewModel = MangamentProductViewModel()
    var router = MangamentProductRouter()
    
    var view1 = OrderProductViewController()
    var view2 = MangamentFoodItemViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        registerOrderProductViewController()
      
     
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListCategoryFood()
    }

    func registerOrderProductViewController() {
        view_food.backgroundColor = ColorUtils.gray_400()
        lbl_name_listfood.textColor = ColorUtils.gray_400()
        view_foodcombo.backgroundColor = .systemBlue
        lbl_name_foodcombo.textColor = .systemBlue
        view1 = OrderProductViewController(nibName: "OrderProductViewController", bundle: .main) as! OrderProductViewController
        addTopCustomViewController(view1, addTopCustom: 100)
        view2.remove()
    }

    func viewControllerProduct() {
       
        view_food.backgroundColor = .systemBlue
        lbl_name_listfood.textColor = .systemBlue
        view_foodcombo.backgroundColor = ColorUtils.gray_400()
        lbl_name_foodcombo.textColor = ColorUtils.gray_400()
        view2 = MangamentFoodItemViewController(nibName: "MangamentFoodItemViewController", bundle: .main) as! MangamentFoodItemViewController
              addTopCustomViewController(view2, addTopCustom: 100)
        view1.remove()
    }
    
    
    @IBAction func btn_makeTocreateProduct(_ sender: Any) {
        viewModel.makeToCreateViewController()
    }
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    @IBAction func btn_choose_listfood(_ sender: Any) {
       
        self.viewControllerProduct()
    }
    
    
    @IBAction func btn_choose_listcombo(_ sender: Any) {
       
        self.registerOrderProductViewController()
    }
    
    
}

extension MangamentProductViewController {
    func getListCategoryFood() {
            viewModel.getListCategoryFood().subscribe(onNext: {
                (response) in
                if response.code == RRHTTPStatusCode.ok.rawValue{
                    if let data = Mapper<CategoryFood>().mapArray(JSONObject:response.data) {
                        self.viewModel.dataArray.accept(data)
                    }
                }
            })
        }
}
