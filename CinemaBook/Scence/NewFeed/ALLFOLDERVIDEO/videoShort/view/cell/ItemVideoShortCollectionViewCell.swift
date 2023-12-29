//
//  ItemVideoShortCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import AVFoundation

class ItemVideoShortCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btn_makeToDetailVideoShortViewController: UIButton!
    @IBOutlet weak var playview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Utils().setupvideo(url: "http://localhost:5062/Uploads/Movie/videotest.mp4/videotest.mp4", type: 0,view: playview, heights: 0)
    }
    
   

    var data:String = "" {
        didSet {
            
        }
    }
    func updateUI(isExpanded: Bool) {
        // Update the cell's UI based on the isExpanded flag
        if isExpanded {
            // Update the cell's UI for expanded state
        } else {
            // Update the cell's UI for collapsed state
        }
    }

}
