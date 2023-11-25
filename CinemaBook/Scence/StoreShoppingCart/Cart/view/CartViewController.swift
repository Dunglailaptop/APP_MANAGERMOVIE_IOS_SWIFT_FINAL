//
//  CartViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 13/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import JonAlert

class CartViewController: UIViewController {

    @IBOutlet weak var lbl_name_cinema: UILabel!
    @IBOutlet weak var lbl_total_number: UILabel!
    @IBOutlet weak var lbl_number: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var idcinema = 0
    var namecinema = ""
    var dateorder = ""
    var viewModel = CartViewModel()
    var router = CartRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        register()
        bindingtable()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_name_cinema.text = namecinema
      
        var countnumber = 0
        var combinedCartItems = [Int: FoodCombo]()

        for foodCombo in ManageCacheObject.getCartInfo() {
            if let existingCartItem = combinedCartItems[foodCombo.idcombo] {
                // Nếu đã tồn tại phần tử với cùng idcombo
                combinedCartItems[foodCombo.idcombo]!.quantityRealtime += foodCombo.quantityRealtime  // Cập nhật số lượng
            } else {
                // Nếu chưa tồn tại phần tử với idcombo này, thêm vào Dictionary
                combinedCartItems[foodCombo.idcombo] = foodCombo
            }
        }

        // Kết quả sẽ là combinedCartItems, đây là mảng gồm các phần tử đã được gộp lại
        var combinedArray = Array(combinedCartItems.values)
        viewModel.dataArrayFoodCombo.accept(combinedArray)
        combinedArray.enumerated().forEach{ (index,value) in
            countnumber += value.quantityRealtime
        }
        lbl_number.text = String(countnumber)
        lbl_total_number.text = Utils.stringVietnameseFormatWithNumber(amount: viewModel.dataArrayFoodCombo.value.map{$0.priceCombo * $0.quantityRealtime}.reduce(0, +))
      


    }

    @IBAction func btn_paymentfoodcombo(_ sender: Any) {
        if idcinema != 0 {
            var datas = viewModel.dataArrayFoodCombo.value
            dLog(datas)
            let cell = PaymentFoodComboViewController() as! PaymentFoodComboViewController
            cell.idcinema = idcinema
            cell.data = datas
            cell.namecinema = namecinema
            self.navigationController?.pushViewController(cell, animated: true)
        }else {
            JonAlert.showError(message: "Vui lòng chọn rạp chiếu phim hệ thống sẽ ghi nhận rạp mà bạn nhận hàng")
        }
     
    }
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    

}
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let order_detail = viewModel.dataArrayFoodCombo.value[indexPath.row]
            
            // Create a custom view with an image and label
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
            imageView.image = UIImage(named: "icon-delete-white")
            imageView.contentMode = .scaleAspectFit
            imageView.center.x = customView.center.x
            
//            let label = UILabel(frame: CGRect(x: 0, y: 45, width: 100, height: 50))
//            label.text = "HUỶ"
//            label.textAlignment = .center
//            label.textColor = UIColor(hex: "FFFFFF")
            
            customView.addSubview(imageView)
//            customView.addSubview(label)
            
            // Create the swipe action using the custom view
        let cancelFood = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
            let updatedArray = self?.viewModel.dataArrayFoodCombo.value.filter { $0.idcombo != order_detail.idcombo } ?? []
            var countnumber = 0
              // Update the value using accept(_:)
              self?.viewModel.dataArrayFoodCombo.accept(updatedArray)
            ManageCacheObject.clearCartInfo()
            for valuenew in updatedArray {
                countnumber += valuenew.quantityRealtime
                ManageCacheObject.saveCartInfo(valuenew)
            }
            self!.lbl_number.text = String(countnumber)
            self!.lbl_total_number.text = Utils.stringVietnameseFormatWithNumber(amount: updatedArray.map{$0.priceCombo * $0.quantityRealtime}.reduce(0, +))
              tableView.reloadData()
           
                completionHandler(true)
            }
            cancelFood.backgroundColor = .UIColorFromRGB("FF0000")
            cancelFood.image = UIGraphicsImageRenderer(size: customView.bounds.size).image { _ in
                customView.drawHierarchy(in: customView.bounds, afterScreenUpdates: true)
            }
            
            // Configure the swipe action configuration
            let configuration = UISwipeActionsConfiguration(actions: [cancelFood])
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
    }
    
    func register() {
        let cellTable = UINib(nibName: "ItemCartTableViewCell", bundle: .main)
        tableView.register(cellTable, forCellReuseIdentifier: "ItemCartTableViewCell")
        tableView.separatorStyle = .none
        
        tableView.rx.setDelegate(self)
    }
    func bindingtable() {
        viewModel.dataArrayFoodCombo.bind(to: tableView.rx.items(cellIdentifier: "ItemCartTableViewCell", cellType: ItemCartTableViewCell.self)) { (row,data,cell) in
      
           
            cell.data = data
            cell.viewModel = self.viewModel
             
            cell.selectionStyle = .none
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        dLog(viewModel.dataArrayFoodCombo.value[indexPath.row].foods.count)
        return CGFloat((viewModel.dataArrayFoodCombo.value[indexPath.row].foods.count * 10) + 150)
    }
}
