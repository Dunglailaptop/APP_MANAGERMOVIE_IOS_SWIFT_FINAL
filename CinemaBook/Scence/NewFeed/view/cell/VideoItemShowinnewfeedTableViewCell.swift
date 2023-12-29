//
//  VideoItemShowinnewfeedTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/10/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoItemShowinnewfeedTableViewCell: UITableViewCell {

   
    @IBOutlet weak var playervideo: YTPlayerView!
    @IBOutlet weak var lbl_namemovie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: NewFeedViewModel? = nil {
        didSet {
            
        }
    }
    
    var data:Trailler? = nil {
        didSet {
            lbl_namemovie.text = data?.titlevideo
            if data?.types == 0 {
                playervideo.load(withVideoId: data!.videofile)
             
            } else {
                Utils().setupvideo(url: Utils.getFullMediaLink(string: data!.videofile), type: 0, view: playervideo,heights: 0)
            }
          
        }
    }
    
}
