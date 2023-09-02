//
//  ItemVideoShortCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class ItemVideoShortCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playview: YTPlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupvideo(url:String) {
        playview.loadVideo(byURL: "", startSeconds: 3)
    }

}
