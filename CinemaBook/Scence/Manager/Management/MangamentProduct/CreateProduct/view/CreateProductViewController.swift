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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view:self,router:router)
        validate()
        regiter()
        bindingtable()
        getListFood()
        // Do any additional setup after loading the view.
    }


 
    @IBAction func BTN_SHOW_LISTTAGLIST(_ sender: Any) {
     var height = 20 +  CGFloat(self.viewModel.dataArray.value.count * 50)
        heighttable.constant = heighttable.constant == 0 ? height : 0
        
    }
    
    
    @IBAction func btn_show_computer(_ sender: Any) {
        presentModalInputMoneyViewController(current_money: 1000)
    }
    
    
    @IBAction func btn_createFoodCombo(_ sender: Any) {
        imagecover.count > 0 ? self.postUpdateWithAvatar() : createFoodCombo()
    }
    
    @IBAction func open_image(_ sender: Any) {
        openPhotoLibrary()
    }
}
