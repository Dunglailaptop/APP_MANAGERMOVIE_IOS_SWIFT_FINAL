//
//  itemTimeCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class itemTimeCollectionViewCell: UICollectionViewCell {

    var idcinema = 0
    var idroom = 0
    var idinterest = 0
    var idmovie = 0
    
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var btn_makeToBookingChairViewController: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var data: InterestMovie? = nil {
        didSet {
            lbl_time.text = data?.times
        }
    }
    
    var viewModel: TimeShowViewModel? = nil {
        didSet {
            
        }
    }
    
    @IBAction func btn_makeToChairBookingViewController(_ sender: Any) {
        dLog(idcinema)
        self.viewModel?.navigationToBookingChairViewController(idcinema: idcinema, idroom: idroom, idinterest: idinterest,idmovie: idmovie)
    }
    
}
