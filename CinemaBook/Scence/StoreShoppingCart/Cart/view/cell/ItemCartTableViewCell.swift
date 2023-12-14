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

    @IBOutlet weak var lbl_number: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var height_textview: NSLayoutConstraint!
    @IBOutlet weak var txt_view_list_food: UITextView!
    @IBOutlet weak var image_food: UIImageView!
   
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
            lbl_name.text = data?.nametittle
            lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: data!.priceCombo * data!.quantityRealtime)
            self.image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.picture)), placeholder:  UIImage(named: "image_defauft_medium"))
         
            lbl_number.text = String(data!.quantityRealtime)
            var textlistfood = ""
            var textsl = 0

            data?.foods.enumerated().forEach { (index,value) in
                dLog(value.quantityRealTime)
                textsl = value.quantityRealTime
                textlistfood += "+\(textsl)x\(value.namefood)\n"
            }

            txt_view_list_food.text = textlistfood
            height_textview.constant = CGFloat((data?.foods.count)! * 20)
            
        }
    }
    
   
    @IBAction func btn_minus(_ sender: Any) {
        var dataget = viewModel?.dataArrayFoodCombo.value
        dataget?.enumerated().forEach{(index,value) in
            if value.idcombo == data?.idcombo && data!.quantityRealtime > 1 {
                dataget![index].quantityRealtime -= 1
               
            }
            lbl_number.text = String(dataget![index].quantityRealtime)
            dLog(dataget![index].quantityRealtime)
        }
        viewModel?.dataArrayFoodCombo.accept(dataget!)
        viewModel?.view?.lbl_total_number.text = Utils.stringVietnameseFormatWithNumber(amount: viewModel!.dataArrayFoodCombo.value.map{$0.priceCombo * $0.quantityRealtime}.reduce(0, +))
    }
    
    @IBAction func btn_plus(_ sender: Any) {
        var dataget = viewModel?.dataArrayFoodCombo.value
        dataget?.enumerated().forEach{(index,value) in
            if value.idcombo == data?.idcombo {
                dataget![index].quantityRealtime += 1
               
            }
            lbl_number.text = String(dataget![index].quantityRealtime)
            dLog(dataget![index].quantityRealtime)
        }
        viewModel?.dataArrayFoodCombo.accept(dataget!)
        viewModel?.view?.lbl_total_number.text = Utils.stringVietnameseFormatWithNumber(amount: viewModel!.dataArrayFoodCombo.value.map{$0.priceCombo * $0.quantityRealtime}.reduce(0, +))
    }
}
