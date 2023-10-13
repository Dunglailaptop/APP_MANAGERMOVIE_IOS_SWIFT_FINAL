//
//  ItemCartTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 13/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class ItemCartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var btn_descreas: UIButton!
    @IBOutlet weak var btn_inscrease: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: CartViewModel? = nil {
        didSet {
            
        }
    }
    
    var data: FoodCombo? = nil {
        didSet {
            var data = viewModel?.dataArrayFoodCombo.value
            btn_inscrease.rx.tap.asDriver().drive(onNext: {
                data?.enumerated().forEach{(index,value) in
                    
                }
            })
            btn_inscrease.rx.tap.asDriver().drive(onNext: {
                data?.enumerated().forEach{
                    (index,value) in
                }
            })
        }
    }
    
   
    
}
