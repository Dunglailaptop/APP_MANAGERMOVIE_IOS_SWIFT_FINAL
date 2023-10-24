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

class ManagementCategoryChairViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.register()
        // Do any additional setup after loading the view.
    }

    var viewModel: ManagementRoomViewModel? = nil {
        didSet {
            getListCategory()
        
        }
    }

    @IBAction func btn_show_createCategoryView(_ sender: Any) {
        presentDialogCreateCategoryChair()
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
    
    func getListCategory(){
        viewModel?.getListCategoryChair().subscribe(onNext: { [self]
            (response) in
            dLog(response)
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<CategoryChair>().mapArray(JSONObject: response.data) {
                    dLog(data)
                    self.viewModel?.dataArrayCategoryChair.accept(data)
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
    func createCategoryChair() {
        viewModel?.getListCategoryChair().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok
                .rawValue {
                if let data = Mapper<CategoryChair>().map(JSONObject: response.data) {
                    JonAlert.showSuccess(message: "Tạo loại ghế mới thành công")
                }
            }
        })
    }
}

extension ManagementCategoryChairViewController: DialogCreateCategoryChair {
    func callbackcreateCategoryChair(categorychairinfo: CategoryChair) {
        viewModel?.dataCategoryChair.accept(categorychairinfo)
        createCategoryChair()
    }
    
    func presentDialogCreateCategoryChair() {
            let DialogShowListChairEditViewControllers = DialogManagementCategoryChairViewController()
        DialogShowListChairEditViewControllers.viewModel = self.viewModel
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
