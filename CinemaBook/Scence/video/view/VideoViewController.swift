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
    
    var viewModel = videoViewModel()
    var router = videoRouter()
    var videoId = ""

    @IBOutlet var playerview: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self,router: router)
      self.setupVideoyoutube(url: videoId)
        // Do any additional setup after loading the view.
    }

    func setupVideoyoutube(url:String){
           playerview.load(withVideoId: url)
       }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
}
