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

class HomeViewController: BaseViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
   var viewModel = HomeViewModel()
    var router = HomeRouter()
    @IBOutlet weak var avatar: UIImageView!
    
  
    @IBOutlet weak var lbl_movie_coming: UILabel!
    @IBOutlet weak var view_movie_coming: UIView!
    @IBOutlet weak var lbl_movie_now: UILabel!
    @IBOutlet weak var view_movienow: UIView!
    @IBOutlet weak var collection_view: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        Register()
        bindingtable()
       setupView()
        FireBaseManager.shared.LoginUser(email: "ndung983@gmail.com", password: "123456")
  
    
//       testSocket()
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
       
    }
    
    @IBAction func btn_movienow(_ sender: Any) {
        view_movie_coming.backgroundColor = .white
        lbl_movie_coming.textColor = .blue
        view_movienow.backgroundColor = .blue
        lbl_movie_now.textColor = .white
        var data = viewModel.pagigation.value
        data.status = 1
        viewModel.pagigation.accept(data)
        self.getListMovieShowBanner()
    }
    
    @IBAction func btn_moviecoming(_ sender: Any) {
        view_movienow.backgroundColor = .white
        lbl_movie_now.textColor = .blue
        view_movie_coming.backgroundColor = .blue
        lbl_movie_coming.textColor = .white
        var data = viewModel.pagigation.value
        data.status = 0
        viewModel.pagigation.accept(data)
        self.getListMovieShowBanner()
    }
}
