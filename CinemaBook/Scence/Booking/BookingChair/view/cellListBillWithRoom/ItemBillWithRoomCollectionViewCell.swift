//
//  ItemBillWithRoomCollectionViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 05/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class ItemBillWithRoomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btn_makeToDetail: UIButton!
    @IBOutlet weak var lbl_totalamount: UILabel!
    @IBOutlet weak var lbl_numberchair: UILabel!
    @IBOutlet weak var lbl_id_bill: UILabel!
    var idbill = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var viewModel: BookingChairViewModel? = nil {
        didSet {
  
          
        }
    }
    
    @IBAction func btn_makeToDetailBillViewController(_ sender: Any) {
        self.viewModel!.makeToDetailBillViewController(idbill: idbill)
    }
    
}
