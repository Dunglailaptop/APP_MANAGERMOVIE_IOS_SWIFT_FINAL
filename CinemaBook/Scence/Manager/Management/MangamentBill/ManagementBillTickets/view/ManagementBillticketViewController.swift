//
//  ManagementBillProductViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/26/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper

class ManagementBillticketViewController: BaseViewController {

    var viewModel = ManagementBillticketViewModel()
    var router = ManagementBillticketRouter()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        register()
        bindingtable()
        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListALLbill()
    }

}

extension ManagementBillticketViewController {
    func getListALLbill() {
        viewModel.getListAllBill().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<BillInfoAccount>().mapArray(JSONObject: response.data)
                {
                    self.viewModel.dataArray.accept(data)
                }
            }
        })
    }
}
extension ManagementBillticketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
////        let order_detail = self.viewModel.dataArray.value[indexPath.row]
//
//            // Create a custom view with an image and label
//            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
//
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
//            imageView.image = UIImage(named: "icon-delete-white")
//            imageView.contentMode = .scaleAspectFit
//            imageView.center.x = customView.center.x
//
////            let label = UILabel(frame: CGRect(x: 0, y: 45, width: 100, height: 50))
////            label.text = "HUỶ"
////            label.textAlignment = .center
////            label.textColor = UIColor(hex: "FFFFFF")
//
//            customView.addSubview(imageView)
////            customView.addSubview(label)
//
//            // Create the swipe action using the custom view
//        let cancelFood = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
//
//
//                completionHandler(true)
//            }
//            cancelFood.backgroundColor = .UIColorFromRGB("FF0000")
//            cancelFood.image = UIGraphicsImageRenderer(size: customView.bounds.size).image { _ in
//                customView.drawHierarchy(in: customView.bounds, afterScreenUpdates: true)
//            }
//
//            // Configure the swipe action configuration
//            let configuration = UISwipeActionsConfiguration(actions: [cancelFood])
//            configuration.performsFirstActionWithFullSwipe = false
//
//            return configuration
//    }
    
    func register() {
        let cellview = UINib(nibName: "ManagementBillProductItemTableViewCell", bundle: .main)
        tableView.register(cellview, forCellReuseIdentifier: "ManagementBillProductItemTableViewCell")
        tableView.rx.setDelegate(self)
        tableView.separatorStyle = .none
    }
    
    func bindingtable() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ManagementBillProductItemTableViewCell", cellType: ManagementBillProductItemTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            cell.selectionStyle = .none
        }
    }
}
