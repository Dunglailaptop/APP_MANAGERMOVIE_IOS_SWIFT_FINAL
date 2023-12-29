//
//  itemCardCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 06/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import VerticalCardSwiper
import youtube_ios_player_helper
import RxSwift
import RxCocoa
import RxRelay

class itemCardCell: CardCell {
    @IBOutlet weak var icon_messgae: UIImageView!
    
    @IBOutlet weak var btn_showcomment: UIButton!
    @IBOutlet weak var lbl_pause: UIImageView!
    @IBOutlet weak var lbl_message: UILabel!
    @IBOutlet weak var lbl_heart: UILabel!
    @IBOutlet weak var lbl_like: UILabel!
    @IBOutlet weak var lbl_namevideo: UILabel!
    @IBOutlet weak var icon_like: UIImageView!
    @IBOutlet weak var icon_heart: UIImageView!
    
    @IBOutlet weak var btn_heart: UIButton!
    
    @IBOutlet weak var btn_like: UIButton!
    //    @IBOutlet weak var view_load_videourl: UIView!
    @IBOutlet weak var video_player: YTPlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    
    }
    var viewModel: VideoTraillerShowViewModel? = nil {
        didSet {
           
        }
    }
    var data: [Comments]? = nil {
        didSet {
            dLog(data)
        }
    }
    @IBAction func video_pause_and_stop(_ sender: Any) {
        video_player.pauseVideo()
    }
    
//    @IBAction func btn_show_comment(_ sender: Any) {
//        viewModel?.view?.presentModalDialogConfirmViewController(viewMdeols: viewModel!,dataComments: data!)
//    }
    

}
extension itemCardCell {
   
}
