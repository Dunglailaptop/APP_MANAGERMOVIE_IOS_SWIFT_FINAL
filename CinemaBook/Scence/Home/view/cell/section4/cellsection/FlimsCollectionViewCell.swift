//
//  FlimsCollectionViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 7/16/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class FlimsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var image_poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var viewModel: HomeViewModel? = nil {
        didSet {
            
        }
    }
    
    var data: Movie? = nil {
        didSet {
       
        }
    }
    
    
    @IBAction func btn_makeToDetailViewController(_ sender: Any) {
        dLog("vao day")
        self.viewModel?.maketoDetailViewContrller(idmovie: data!.movieID)
    }
    
}
