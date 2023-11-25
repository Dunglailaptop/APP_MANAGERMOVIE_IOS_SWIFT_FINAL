//
//  BookingChairViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import JonAlert

class BookingChairViewController: BaseViewController {

    var viewModel = BookingChairViewModel()
    var router = BookingChairRouter()
    var dataChair = [chair]()
    var currentScale: CGFloat = 1.0
    var safeAreaInsets: UIEdgeInsets = .zero
     var originalCollectionViewSize: CGSize = .zero
    var type = 0
    var idcinema = 0
    var idroom = 0
    var idinterest = 0
    var idmovie = 0
    //label
    @IBOutlet weak var height_view_payment: NSLayoutConstraint!
    @IBOutlet weak var lbl_name_cinema: UILabel!
    
    @IBOutlet weak var lbl_namemovie: UILabel!
    @IBOutlet weak var lbl_info_interest: UILabel!
    //view hidden
    @IBOutlet weak var view_height_info: NSLayoutConstraint!
   
    @IBOutlet weak var view_info_room: UIView!
    
    @IBOutlet weak var view_payment: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var view_collection: UICollectionView!
    
    @IBOutlet weak var view_of_collectionview: UIView!
    @IBOutlet weak var view_of_collection: UIView!
    
    @IBOutlet weak var lbl_price_chair: UILabel!
    @IBOutlet weak var scroll_view_zoom: UIScrollView!
    
    @IBOutlet weak var lbl_number_chair: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
        view_of_collectionview.backgroundColor = ColorUtils.backgroudcolor()
        scroll_view_zoom.delegate = self
//        originalCollectionViewSize = view_collection.frame.size
//        view_collection.contentSize = CGSize(width: 100, height: 100)
//        NSLayoutConstraint.activate([
//            view_collection.topAnchor.constraint(equalTo: scroll_view_zoom.topAnchor, constant: 0),
//                 view_collection.leadingAnchor.constraint(equalTo: scroll_view_zoom.leadingAnchor,constant: 0),
//                 view_collection.trailingAnchor.constraint(equalTo: scroll_view_zoom.trailingAnchor,constant: 0),
//                 view_collection.bottomAnchor.constraint(equalTo: scroll_view_zoom.bottomAnchor,constant: 0)
//             ])
        
      resgisterCollection()
        binđDataTableCollectionView()
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.onDidReceiveNotification(_:)), name: NSNotification.Name("NotificationCallApi"), object: nil)
       
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            var data = viewModel.pagition.value
            data.idroom = idroom
            data.idinterest = idinterest
            data.idcinema = idcinema
            data.idmovie = idmovie
            viewModel.pagition.accept(data)
        
        if type == 1{
            self.view_info_room.isHidden = true
            self.view_payment.isHidden = true
            self.view_height_info.constant = 0
//            getListchairRoom()
        }else  {
                self.view_info_room.isHidden = false
                self.view_payment.isHidden = false
                self.view_height_info.constant = 40
            getListchair()
        }
      
        
    }
    
    @objc func onDidReceiveNotification(_ notification: Notification)
      {
       
          
        dLog(notification.userInfo?["userInfo"])
        var Idroom = notification.userInfo?["userInfo"]
        var data = viewModel.pagition.value
        data.idroom = Idroom as! Int
        viewModel.pagition.accept(data)
        getListchairRoom()
      }
    
   
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    
    @IBAction func btn_makeToBookingProductCombo(_ sender: Any) {
        var datafilter = viewModel.dataArray.value.filter{$0.isSelected == ACTIVE}
        if datafilter.count > 0 {
            viewModel.makeToBookingProductComboViewController(dataInfoMovie: viewModel.infoInterestMovie.value,datachairs: datafilter)
        }else {
            JonAlert.showError(message: "Vui lòng chọn ghế để thực hiện thanh toán")
        }
       
    }
    
}
extension BookingChairViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return view_collection
    }

}
