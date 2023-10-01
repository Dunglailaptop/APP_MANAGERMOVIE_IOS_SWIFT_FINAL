//
//  CreateProductViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import TagListView
import RxSwift
import RxCocoa
import ObjectMapper
import MWPhotoBrowser

class CreateProductViewController: BaseViewController {

    var viewModel = CreateProductViewModel()
    var router = CreateProductRouter()
    
    @IBOutlet weak var avatar: UIImageView!
    var type = ""
    @IBOutlet weak var txt_discription: UITextView!
    @IBOutlet weak var txt_number_price: UITextField!
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var Taglistview: TagListView!
    @IBOutlet weak var heighttable:NSLayoutConstraint!
    @IBOutlet weak var height_Scroll: NSLayoutConstraint!
    @IBOutlet weak var heigth_taglist: NSLayoutConstraint!
    var imagecover = [UIImage]()
      var selectedAssets = [PHAsset]()
     var nameImage: [String] = []
    var foodcombo = FoodCombo()
    
    @IBOutlet weak var BTN_EDITS: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view:self,router:router)
        validate()
        regiter()
        bindingtable()
       
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var data = viewModel.dataMap.value
        data.idcombo = foodcombo.idcombo
        data.nametittle = foodcombo.nametittle
        data.picture = foodcombo.picture
        data.priceCombo = foodcombo.priceCombo
        data.descriptions = foodcombo.descriptions
        viewModel.dataMap.accept(data)
        getListFood()
        setupvalid(data: foodcombo)
        checkEdit()
    }
    
    func checkEdit() {
        switch type {
              case "CREATE":
                BTN_EDITS.setTitle("TẠO MÓN COMBO", for: .normal)
                 break
              case "UPDATE":
                BTN_EDITS.setTitle("CẬP NHẬT", for: .normal)
                 break
              default:
                  return
              }
    }
    
    func setupvalid(data:FoodCombo) {
        txt_name.text = data.nametittle
        txt_number_price.text = Utils.stringVietnameseFormatWithNumber(amount: data.priceCombo)
        txt_discription.text = data.descriptions
        var dataMaps = viewModel.dataMap.value
        dataMaps.idcombo = data.idcombo
        viewModel.dataMap.accept(dataMaps)
        avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data.picture)), placeholder: UIImage(named: "image_defauft_medium"))
      
    }
    func setuptaglist(data:FoodCombo) {
        var dataFood = viewModel.dataArray.value
              dLog(dataFood)
              dataFood.enumerated().forEach{ (index,value) in
                  data.foods.enumerated().forEach{
                      (index1,value1) in
                      if value.idfood == value1.idfood {
                          dataFood[index].isSelected = ACTIVE
                        dataFood[index].idcombo = value1.idcombo
                        dataFood[index].id = value1.id
                          Taglistview.addTag(value.namefood)
                      }
                  }
              }
              viewModel.dataArray.accept(dataFood)
    }

 
    @IBAction func BTN_SHOW_LISTTAGLIST(_ sender: Any) {
     var height = 20 +  CGFloat(self.viewModel.dataArray.value.count * 50)
        heighttable.constant = heighttable.constant == 0 ? height : 0
        
    }
    
    
    @IBAction func btn_show_computer(_ sender: Any) {
        presentModalInputMoneyViewController(current_money: 1000)
    }
    
    
    @IBAction func btn_createFoodCombo(_ sender: Any) {
        switch type {
        case "CREATE":
               imagecover.count > 0 ? self.postUpdateWithAvatar() : createFoodCombo()
            break
        case "UPDATE":
              imagecover.count > 0 ? self.postUpdateWithAvatar() : updateFoodCombo()
            break
        default:
            return
        }
     
    }
    
    @IBAction func open_image(_ sender: Any) {
        openPhotoLibrary()
    }
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
}
