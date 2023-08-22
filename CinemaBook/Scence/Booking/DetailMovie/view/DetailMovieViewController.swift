//
//  DetailMovieViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/14/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import AVFoundation
import youtube_ios_player_helper

class DetailMovieViewController: BaseViewController {

    var viewModel = DetailMovieviewModel()
    var router = DetailMovieRouter()
    
    @IBOutlet weak var view_video: UIView!
    
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var lbl_namemovie: UILabel!
    
    @IBOutlet weak var lbl_yeahshow: UILabel!
    
    @IBOutlet weak var lbl_timeall: UILabel!
    
    @IBOutlet weak var lbl_category: UILabel!
    
    @IBOutlet weak var lbl_author: UILabel!
    
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    
    @IBOutlet weak var lblheight: NSLayoutConstraint!
    
    
    @IBOutlet weak var lbl_text: UILabel!
    @IBOutlet weak var btn_readmore: UIButton!
    @IBOutlet var playerview: YTPlayerView!
    
    var islabelatMaxHeight = true
    
    var idmovie = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        readMore()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.idmovie.accept(idmovie)
        getDetailMovie()
        
    }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    
    @IBAction func btn_read_more(_ sender: Any) {
      readMore()
    }
    
    func getlabelheight(text: String, width: CGFloat)-> Float{
        let lbl = UILabel(frame: .zero)
        lbl.frame.size.width = width
       
        lbl.numberOfLines = 0
        lbl.text = text
        lbl.sizeToFit()
        
        return Float(lbl.frame.size.height)
    }
    
    func readMore(){
       if islabelatMaxHeight {
       btn_readmore.setTitle("đọc thêm", for: .normal)
       islabelatMaxHeight = false
       lblheight.constant = 70
     
        }else{
         btn_readmore.setTitle("đọc thêm", for: .normal)
         islabelatMaxHeight = true
        lblheight.constant = CGFloat(getlabelheight(text: lbl_text.text!, width: view.bounds.width))
       
         }
          viewheight.constant = lblheight.constant + 50
    }
    
    
    @IBAction func btn_maketoBookingChairViewController(_ sender: Any) {
        viewModel.makeToBookingChairViewController()
    }
    
}

extension DetailMovieViewController {
    func setupvideo(url:String) {
           let videoUrl = URL(string:url)
           let player = AVPlayer(url: videoUrl!)
           let playerplay = AVPlayerLayer(player: player)
        playerplay.frame = self.view_video.bounds
        playerplay.videoGravity = .resizeAspectFill
        self.view_video.layer.addSublayer(playerplay)
        player.play()
         }
   
}
