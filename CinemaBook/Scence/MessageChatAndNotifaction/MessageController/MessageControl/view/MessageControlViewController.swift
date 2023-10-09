//
//  MessageControlViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class MessageControlViewController: UIViewController {

    var views = MessageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        addTopCustomViewController(views, addTopCustom: 0)
      
    }


   

}
