//
//  ItemDetailVideoShortCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ItemDetailVideoShortCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var view_player: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupvideo()
//        // Initialization code
         Utils().setupvideo(url: "http://localhost:5062/Uploads/Movie/videotest.mp4/videotest.mp4", type: 1,view: view_player)
    }
//    func setupvideo() {
//        let videoUrl = URL(string: "http://localhost:5062/Uploads/Movie/videotest.mp4/videotest.mp4")!
//                  let player = AVPlayer(url: videoUrl)
//                  let playerLayer = AVPlayerLayer(player: player)
//                playerLayer.frame = view_player.bounds
//                  playerLayer.videoGravity = .resizeAspectFill
//
//
//                  player.play()
//    }
}
