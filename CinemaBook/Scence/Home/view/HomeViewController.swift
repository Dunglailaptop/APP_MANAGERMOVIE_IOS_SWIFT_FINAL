//
//  HomeViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import LNICoverFlowLayout
import SocketIO
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
   var viewModel = HomeViewModel()
    var router = HomeRouter()
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var lbl_name_account: UILabel!
    
    @IBOutlet weak var lbl_price_point: UILabel!
    @IBOutlet weak var lbl_movie_coming: UILabel!
  
    @IBOutlet weak var view_detail: UIView!
    
    var rxbag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        Register()
        bindingtable()
       setupView()
//        view_detail.roundCorners([.bottomLeft,.bottomRight], radius: 55)
//        view_detail.clipsToBounds = true
      
       
    
//       testSocket()
    }
    func setupinfo() {
        lbl_name_account.text = "Xin chào," + ManageCacheObject.getCurrentUserInfo().fullname
//        lbl_price_point.text = Utils.stringVietnameseFormatWithNumber(amount: ManageCacheObject.getCurrentUser().point)
        avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: ManageCacheObject.getCurrentUserInfo().avatar)), placeholder: UIImage(named: "image_defauft_medium"))
//        lbl_price_point.text =
    }
   
  

    func testSocket() {
        // Create a Socket.IO client instance
        let socket = SocketManager(socketURL: URL(string: "ws://localhost:5062/chatHub")!, config: [.log(true), .compress])
        let socketClient = socket.defaultSocket

        // Define event handler for receiving messages from the server
        socketClient.on("EnviarMensaje") { (data, ack) in
            if let response = data[0] as? String {
                dLog("Received message from server: \(response)")
            }
        }

        // Define event handler for successful connection
        socketClient.on(clientEvent: .connect) { (data, ack) in
            dLog("Socket connected")

            // Call the EnviarMensaje method after successful connection
            let user = "John"
            let message = "Hello from Swift"

            socketClient.emit("EnviarMensaje", with: [user, message]) {
                // Handle the completion here
            }
        }

        // Define event handler for socket errors
        socketClient.on(clientEvent: .error) { (data, ack) in
            dLog("Socket error: \(data)")
        }

        // Connect to the server
        socketClient.connect()
    }

 

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
               
                 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.getListMovieShowBanner()
       setupinfo()
    }
    
    @IBAction func btn_movienow(_ sender: Any) {
     
        var data = viewModel.pagigation.value
        data.status = 1
        viewModel.pagigation.accept(data)
        self.getListMovieShowBanner()
    }
    
    @IBAction func btn_moviecoming(_ sender: Any) {
     
        var data = viewModel.pagigation.value
        data.status = 0
        viewModel.pagigation.accept(data)
        self.getListMovieShowBanner()
    }
}
