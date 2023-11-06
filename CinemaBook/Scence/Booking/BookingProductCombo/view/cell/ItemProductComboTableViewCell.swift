//
//  ItemProductComboTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 10/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift


class ItemProductComboTableViewCell: UITableViewCell {

    @IBOutlet weak var btn_inscrease: UIButton!
    @IBOutlet weak var btn_descrease: UIButton!
    @IBOutlet weak var lbl_number: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_desscription: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var image_combo: UIImageView!
    var number = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_name.adjustsFontSizeToFitWidth = true
        lbl_desscription.adjustsFontSizeToFitWidth = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: BookingProductComboViewModel? = nil {
        didSet {
            
        }
    }
    
    @IBAction func btn_incease(_ sender: Any) {
        var numbers = 0
         dLog(number)
       
         var dataget = viewModel?.dataArray.value
         dataget?.enumerated().forEach{(index,value) in
             if value.idcombo == data?.idcombo && value.quantity > 0 {
                 dataget![index].quantity -= 1
                 numbers = dataget![index].quantity
             }
         }
         viewModel?.dataArray.accept(dataget!)
         lbl_number.text = String(numbers)
        var prices =  viewModel?.view?.dataChair.map{$0.price}.reduce(0, +)
        var pricecombo = viewModel!.dataArray.value.map{$0.priceCombo * $0.quantity}.reduce(0 ,+)
        self.viewModel?.view?.lbl_price_chair.text = Utils.stringVietnameseFormatWithNumber(amount: pricecombo + prices!)
       
    }
    
    
    @IBAction func btn_includenumber(_ sender: Any) {
  
       var numbers = 0
        dLog(number)
      
        var dataget = viewModel?.dataArray.value
        dataget?.enumerated().forEach{(index,value) in
            if value.idcombo == data?.idcombo {
                dataget![index].quantity += 1
                numbers = dataget![index].quantity
            }
        }
        viewModel?.dataArray.accept(dataget!)
        lbl_number.text = String(numbers)
        var prices =  viewModel?.view?.dataChair.map{$0.price}.reduce(0, +)
        var pricecombo = viewModel!.dataArray.value.map{$0.priceCombo * $0.quantity}.reduce(0 ,+)
        self.viewModel?.view?.lbl_price_chair.text = Utils.stringVietnameseFormatWithNumber(amount: pricecombo + prices!)
 
    }
    
    
    var data:FoodCombo? = nil {
        didSet {
            lbl_name.text = data?.nametittle
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.priceCombo)
            lbl_desscription.text = data?.descriptions
             image_combo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder: UIImage(named: "image_defauft_medium"))
            lbl_number.text = String(data!.quantity)
        }
    }
    
}
