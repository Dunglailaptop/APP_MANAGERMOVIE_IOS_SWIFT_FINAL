//
//  ManagementDetailRoomViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 23/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay
import ObjectMapper
import JonAlert

class ManagementDetailRoomViewController: UIViewController {

    @IBOutlet weak var lbl_number_categoryChair: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var lbl_number_room: UILabel!
    @IBOutlet weak var lbl_name_room: UILabel!
    @IBOutlet weak var lbl_idrom: UILabel!
    var viewModel = ManagementDetailRoomViewModel()
    var router = ManagementDetailRoomRouter()
    var view1 = BookingChairViewController()
    var infoRoom = Room()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        register()
        bindingtable()
        registerViewController()
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name ("listchairs"), object: nil)
        nootifacationSetup()
        // Do any additional setup after loading the view.
    }
    func nootifacationSetup() {
        let notificationName = Notification.Name("NotificationCallApi")
        let loginResponse = ["userInfo": infoRoom.idroom]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: loginResponse)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any] {
                // Access the loginResponse dictionary here
                if let reportType = userInfo["userInfo"] as? [String: Any] {
                    let reportTypeValue = reportType["Report_type"] as? chair 
                 dLog(reportTypeValue)
                    
                    var datachair = viewModel.dataArrayChairChoose.value
                    var check = false
                  
                    if datachair.count > 0 {
                        datachair.enumerated().forEach{ (index,value) in
                            if value.idchair == reportTypeValue?.idchair {
                                datachair.remove(at: index)
                                check = true
                            }
                        }
                        if check == false {
                            datachair.append(reportTypeValue!)
                        }
                    }else
                    {
                        datachair.append(reportTypeValue!)
                    }
                
               
                  
                    viewModel.dataArrayChairChoose.accept(datachair)
                  
                    collectionview.reloadData()
                }
            }
    }
    
    func setup(){
        lbl_idrom.text = String(infoRoom.idroom)
        lbl_name_room.text = infoRoom.nameroom
        lbl_number_room.text = String(infoRoom.allchair)
        lbl_number_categoryChair.text = String(viewModel.dataArrayCategoryChair.value.count)
    }

    func registerViewController() {
        
        view1 = BookingChairViewController(nibName: "BookingChairViewController", bundle: .main) as!  BookingChairViewController
        view1.type = 1
        view1.idroom = 1
     
        addTopCustomViewController(view1, addTopCustom: 230)
        view1.height_view_payment.constant = 0
    }
  
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    
    @IBAction func btn_showDialogListChairEdit(_ sender: Any) {
        viewModel.dataArrayChairChoose.value.count > 0 ? presentDialogEditListChair():JonAlert.showSuccess(message: "Vui lòng ghế cần chỉnh sửa")
    }
    
    
}
extension ManagementDetailRoomViewController {
    func register() {
        let collectioncell = UINib(nibName: "ManagementDetailRoomItemCollectionViewCell", bundle: .main)
        collectionview.register(collectioncell, forCellWithReuseIdentifier: "ManagementDetailRoomItemCollectionViewCell")
        setupCollectionView()
        
    }
    func setupCollectionView() {
                 let layout = UICollectionViewFlowLayout()
                 layout.scrollDirection = .horizontal
                 layout.itemSize = CGSize(width: 100, height: 30)
                 layout.minimumLineSpacing = 5
                 collectionview.collectionViewLayout = layout
                 collectionview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                 collectionview.translatesAutoresizingMaskIntoConstraints = false
             }
    
    func bindingtable() {
        viewModel.dataArrayChairChoose.bind(to: collectionview.rx.items(cellIdentifier: "ManagementDetailRoomItemCollectionViewCell", cellType: ManagementDetailRoomItemCollectionViewCell.self)) {
            (row,data,cell) in
            cell.data = data
        }
    }
}
extension ManagementDetailRoomViewController: DialogUpdateListCategoryChair {
    func callbackUpdatelistcategorychair() {
        JonAlert.showSuccess(message: "Cập nhật danh sách loại ghế thành công")
        dismiss(animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name ("listchairs"), object: nil)
        nootifacationSetup()
    }
    
    func presentDialogEditListChair() {
            let DialogShowListChairEditViewControllers = DialogShowListChairEditViewController()
        DialogShowListChairEditViewControllers.viewModel = self.viewModel
        DialogShowListChairEditViewControllers.listchair = viewModel.dataArrayChairChoose.value
        DialogShowListChairEditViewControllers.delegate = self
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
