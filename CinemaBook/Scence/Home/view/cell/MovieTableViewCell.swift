//
//  MovieTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 7/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var tableview: UITableView!
    
    static let rxbag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: HomeViewModel? {
        didSet{
            
        }
    }
    
}

