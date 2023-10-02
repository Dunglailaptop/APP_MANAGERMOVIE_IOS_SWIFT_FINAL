//
//  ItemProductComboTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 10/1/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class ItemProductComboTableViewCell: UITableViewCell {

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
        if number > 0 {
            number = number - 1
            lbl_number.text = String(number)
            var datacheck = viewModel?.dataArray.value
            datacheck?.enumerated().forEach{ (index,value) in
                if value.idcombo == data?.idcombo {
                            datacheck![index].quantity = number
                      }
                if number > 0 {
                    datacheck?[index].isSelected = ACTIVE
                }
            }
            viewModel?.dataArray.accept(datacheck!)
           var prices =  viewModel?.view?.dataChair.map{$0.price}.reduce(0, +)
            var pricecombo = viewModel?.dataArray.value.map{$0.priceCombo * $0.quantity}.reduce(0 ,+)
            viewModel?.view?.lbl_price_chair.text = Utils.stringVietnameseFormatWithNumber(amount: pricecombo! + prices!)
            
        }
       
    }
    
    
    @IBAction func btn_includenumber(_ sender: Any) {
            number = number + 1
            lbl_number.text = String(number)
                var datacheck = viewModel?.dataArray.value
                datacheck?.enumerated().forEach{ (index,value) in
                    if value.idcombo == data?.idcombo {
                          datacheck![index].quantity = number
                        if number > 0 {
                            datacheck![index].isSelected = ACTIVE
                        }
                    }
                
                }
                viewModel?.dataArray.accept(datacheck!)
                var prices =  viewModel?.view?.dataChair.map{$0.price}.reduce(0, +)
                var pricecombo = viewModel?.dataArray.value.map{$0.priceCombo * $0.quantity}.reduce(0 ,+)
                viewModel?.view?.lbl_price_chair.text = Utils.stringVietnameseFormatWithNumber(amount: pricecombo! + prices!)
    }
    
    
    var data:FoodCombo? = nil {
        didSet {
            lbl_name.text = data?.nametittle
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.priceCombo)
            lbl_desscription.text = data?.descriptions
             image_combo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder: UIImage(named: "image_defauft_medium"))
        }
    }
    
}
