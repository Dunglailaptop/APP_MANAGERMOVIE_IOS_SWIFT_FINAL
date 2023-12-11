//
//  ManagementCategoryChairViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/24/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import JonAlert

class ManagementCategoryChairViewController: BaseViewController {

    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.register()
        txt_search.rx.controlEvent(.editingChanged)
                   .withLatestFrom(txt_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       guard self != nil else { return }
                
                       let dataFirsts = viewModel?.dataArrayCategoryChairsearch.value
                       let cloneDataFilter = viewModel?.dataArrayCategoryChair.value
                       if !query!.isEmpty{
                           var filteredDataArray = cloneDataFilter!.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str2 = value.namecategorychair.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               return str2.contains(str1)
                           })
                           viewModel?.dataArrayCategoryChair.accept(filteredDataArray)
                           tableView.reloadData()
                       }else{
                           viewModel?.dataArrayCategoryChair.accept(dataFirsts!)
                           tableView.reloadData()
                          
                       }
                       
        }).disposed(by: rxbag)
        // Do any additional setup after loading the view.
    }

    var viewModel: ManagementRoomViewModel? = nil {
        didSet {
            getListCategory()
        
        }
    }

    @IBAction func btn_show_createCategoryView(_ sender: Any) {
        presentDialogCreateCategoryChair(TYPE: "CREATE",idcategorys: 0)
    }
    

}
extension ManagementCategoryChairViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.dataArrayCategoryChair.value.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCategoryChairTableViewCell", for: indexPath) as! ItemCategoryChairTableViewCell
        cell.lbl_name_chair.text = viewModel?.dataArrayCategoryChair.value[indexPath.row].namecategorychair
        var collorhex = viewModel?.dataArrayCategoryChair.value[indexPath.row].colorchair.removeCharacters(from: "#")
        cell.view_color_chair.backgroundColor = UIColor(hex: collorhex!)
        cell.lbl_price_chair.text = Utils.stringVietnameseFormatWithNumber(amount: (viewModel?.dataArrayCategoryChair.value[indexPath.row].price)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let order_detail = viewModel?.dataArrayCategoryChair.value[indexPath.row]
            
            // Create a custom view with an image and label
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
            imageView.image = UIImage(named: "edit")
            imageView.contentMode = .scaleAspectFit
            imageView.center.x = customView.center.x
            
            let label = UILabel(frame: CGRect(x: 0, y: 45, width: 80, height: 30))
            label.text = "Chỉnh sửa"
            label.textAlignment = .center
            label.textColor = UIColor(hex: "34C759")
            
            customView.addSubview(imageView)
            customView.addSubview(label)
            
            // Create the swipe action using the custom view
            let cancelFood = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
                self!.presentDialogCreateCategoryChair(TYPE: "DETAIL",idcategorys: order_detail!.idcategorychair)
                completionHandler(true)
            }
            cancelFood.backgroundColor = .UIColorFromRGB("DFEEE2")
            cancelFood.image = UIGraphicsImageRenderer(size: customView.bounds.size).image { _ in
                customView.drawHierarchy(in: customView.bounds, afterScreenUpdates: true)
            }
            
            // Configure the swipe action configuration
            let configuration = UISwipeActionsConfiguration(actions: [cancelFood])
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
    }
    
    func getListCategory(){
        viewModel?.getListCategoryChair().subscribe(onNext: { [self]
            (response) in
            dLog(response)
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<CategoryChair>().mapArray(JSONObject: response.data) {
                    dLog(data)
                    self.viewModel?.dataArrayCategoryChair.accept(data)
                    self.viewModel?.dataArrayCategoryChairsearch.accept(data)
                    dLog(self.viewModel?.dataArrayCategoryChair.value)
                    self.tableView.reloadData()
                  
                }
            }
        })
    }
    
    func register() {
        let cell = UINib(nibName: "ItemCategoryChairTableViewCell", bundle: .main)
        tableView.register(cell, forCellReuseIdentifier: "ItemCategoryChairTableViewCell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
       
    }

}
extension ManagementCategoryChairViewController {
    func updateinfocategorychair() {
        viewModel?.updateinfocategorychairwithinfo().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                JonAlert.showSuccess(message: "Cập nhật thông tin loại ghế thành công")
                self.dismiss(animated: true)
                self.getListCategory()
            }else {
                JonAlert.showError(message: "Có lỗi xảy ra trong quá trình kết nối")
            }
        })
    }
    
    
    func createCategoryChair() {
        viewModel?.createCategoryChair().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok
                .rawValue {
                if let data = Mapper<CategoryChair>().map(JSONObject: response.data) {
                    JonAlert.showSuccess(message: "Tạo loại ghế mới thành công")
                    self.dismiss(animated: true)
                }else {
                    JonAlert.showError(message: "Tạo loại ghế thất bại")
                }
            }
        })
    }
}

extension ManagementCategoryChairViewController: DialogCreateCategoryChair {
    func callbackcreateCategoryChair(categorychairinfo: CategoryChair,type:String) {
        switch type {
        case "CREATE":
//            viewModel?.dataCategoryChair.accept(categorychairinfo)
            var datacategorychair = viewModel?.dataCategoryChair.value
            datacategorychair?.namecategory = categorychairinfo.namecategory
            datacategorychair?.colorchair = categorychairinfo.colorchair
            datacategorychair?.price = categorychairinfo.price
            datacategorychair?.idroom = categorychairinfo.idroom
            viewModel?.dataCategoryChair.accept(categorychairinfo)
            dLog(categorychairinfo)
            createCategoryChair()
        case "DETAIL":
            viewModel?.dataCategoryChair.accept(categorychairinfo)
            dLog(categorychairinfo)
            updateinfocategorychair()
        default:
            return
        }
       
       
    }
    
    func presentDialogCreateCategoryChair(TYPE:String,idcategorys:Int) {
            let DialogShowListChairEditViewControllers = DialogManagementCategoryChairViewController()
        DialogShowListChairEditViewControllers.viewModel = self.viewModel
        DialogShowListChairEditViewControllers.delegate = self
        DialogShowListChairEditViewControllers.type = TYPE
        DialogShowListChairEditViewControllers.idcategory = idcategorys
        DialogShowListChairEditViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
            let nav = UINavigationController(rootViewController: DialogShowListChairEditViewControllers)
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

