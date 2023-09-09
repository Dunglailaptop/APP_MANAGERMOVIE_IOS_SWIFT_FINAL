//
//  itemTraillerCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/7/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import MarqueeLabel

class itemTraillerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_tittle: UILabel!
    @IBOutlet weak var video: YTPlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var data: Trailler? = nil {
        didSet {
            lbl_tittle.text = data?.titlevideo
            if data?.types == 0 {
                video.load(withVideoId: data!.videofile)

            }else {
                
            }
        }
    }

}
