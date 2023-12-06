//
//  MangamentFoodItemViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ObjectMapper

class MangamentFoodItemViewController: BaseViewController {
    var viewModel = MangamentFoodItemViewModel()
    var router = MangamentFoodItemRouter()
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var view_no_data: UIView!
    @IBOutlet weak var collectionview_categoryfood: UICollectionView!
    @IBOutlet weak var txt_search: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router:  router)
        register()
        bindingtableviewcell()
        resgitercollection()
        bindingcollection()
        txt_search.rx.controlEvent(.editingChanged)
                   .withLatestFrom(txt_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       guard self != nil else { return }
                
                       let dataFirsts = viewModel.dataArraySearch.value
                       let cloneDataFilter = viewModel.dataArray.value
                       if !query!.isEmpty{
                           var filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               let str2 = value.namefood.uppercased().applyingTransform(.stripDiacritics, reverse: false)
                               return str2!.contains(str1!)
                           })
                           viewModel.dataArray.accept(filteredDataArray)
                      
                       }else{
                           viewModel.dataArray.accept(dataFirsts)
                          
                          
                       }
                       
                   }).disposed(by: rxbag)
        getListFood()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getlistcategoryfood()
    }
   
    @IBAction func btn_MakeToCreateFoodViewController(_ sender: Any) {
        presentModalDialogCreateFood(idfood: 0,type: "CREATE")
    }
    
}
extension MangamentFoodItemViewController
{
    func resgitercollection() {
        let cellcollection = UINib(nibName: "ItemCategoryFoodCollectionViewCell", bundle: .main)
        collectionview_categoryfood.register(cellcollection, forCellWithReuseIdentifier: "ItemCategoryFoodCollectionViewCell")
        collectionview_categoryfood.rx.modelSelected(CategoryFood.self).subscribe(onNext: {
           element in
            dLog(element)
            var datacategoryfood = self.viewModel.datacategoryfood.value
            datacategoryfood.enumerated().forEach{ (index,value) in
                if value.idcategoryfood == element.idcategoryfood && element.selected == DEACTIVE  {
                    datacategoryfood[index].selected = ACTIVE
                    self.viewModel.idcategory.accept(element.idcategoryfood)
                    
                    } else {
                    datacategoryfood[index].selected = DEACTIVE
                }
            }
            self.getListFood()
            self.viewModel.datacategoryfood.accept(datacategoryfood)
        })
        setupCollection()
    }
    func setupCollection() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 40)
        collectionview_categoryfood.collectionViewLayout = layout
    }
    func bindingcollection() {
        viewModel.datacategoryfood.bind(to: collectionview_categoryfood.rx.items(cellIdentifier: "ItemCategoryFoodCollectionViewCell",cellType: ItemCategoryFoodCollectionViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            
        }
    }
}

extension MangamentFoodItemViewController {
    func getlistcategoryfood() {
        viewModel.getListCategoryFood().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<CategoryFood>().mapArray(JSONObject: response.data){
                    self.viewModel.datacategoryfood.accept(data)
                    self.getListFood()
                }
            }
        })
    }
    func getListFood() {
        viewModel.getListFood().subscribe(onNext: {(response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Food>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                    self.viewModel.dataArraySearch.accept(data)
                    self.view_no_data.isHidden = self.viewModel.dataArray.value.count == 0 ? false:true
                }
            }
        })
    }
}

extension MangamentFoodItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func register() {
        let celltable = UINib(nibName: "ItemFoodInManagementTableViewCell", bundle: .main)
        tableview.register(celltable, forCellReuseIdentifier: "ItemFoodInManagementTableViewCell")
        tableview.separatorStyle = .none
        tableview.rx.setDelegate(self)
        tableview.rx.modelSelected(Food.self).subscribe(onNext: { [self]
            element in
            presentModalDialogCreateFood(idfood: element.idfood,type: "DETAIL")
        })
    }
    
    func bindingtableviewcell() {
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "ItemFoodInManagementTableViewCell", cellType: ItemFoodInManagementTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
}
extension MangamentFoodItemViewController {
    func presentModalDialogCreateFood(idfood:Int,type:String) {
        
        let DialogCreateFoodViewControllers = DialogCreateFoodViewController()
        DialogCreateFoodViewControllers.type = type
        DialogCreateFoodViewControllers.idfood = idfood
        DialogCreateFoodViewControllers.viewModel = self.viewModel
        DialogCreateFoodViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
   
        let nav = UINavigationController(rootViewController: DialogCreateFoodViewControllers)
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
