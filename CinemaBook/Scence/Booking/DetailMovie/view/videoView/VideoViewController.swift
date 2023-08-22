//
//  VideoViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/22/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.setupVideoyoutube(url: "TcMBFSGVi1c")
        // Do any additional setup after loading the view.
    }

    func setupVideoyoutube(url:String){
           playerview.load(withVideoId: url)
       }

}
