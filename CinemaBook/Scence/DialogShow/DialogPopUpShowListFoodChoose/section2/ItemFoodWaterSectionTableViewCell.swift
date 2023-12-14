//
//  ItemFoodWaterSectionTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 12/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ItemFoodWaterSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellFoodWater = UINib(nibName: "ItemDialogFoodComboWaterTableViewCell", bundle: .main)
        tableView.register(cellFoodWater, forCellReuseIdentifier: "ItemDialogFoodComboWaterTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var viewModel: DetailProductViewModel? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
}
extension ItemFoodWaterSectionTableViewCell: UITableViewDelegate,UITableViewDataSource {
 

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data = self.viewModel?.dataArrayFoodWater.value
        data?.enumerated().forEach{
            (index,value) in
            if value.idfood == viewModel?.dataArrayFoodWater.value[indexPath.row].idfood && value.isSelected == DEACTIVE {
                data![index].isSelected = ACTIVE
                data![index].quantityRealTime = 1
            }else if viewModel!.dataArrayFoodWater.value.filter{$0.isSelected == ACTIVE}.count > 0  {
                data![index].isSelected = DEACTIVE
                data![index].quantityRealTime = 0
            }
             
            
            
        }
        self.viewModel?.dataArrayFoodWater.accept(data!)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataArrayFoodWater.value.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDialogFoodComboWaterTableViewCell", for: indexPath) as! ItemDialogFoodComboWaterTableViewCell
        cell.lbl_name_food.text = viewModel?.dataArrayFoodWater.value[indexPath.row].namefood
//        cell.lbl_number.text = String(viewModel!.dataArrayFoodWater.value[indexPath.row].quantityRealTime)
        var data = viewModel?.dataArrayFoodWater.value
        cell.image_view.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: (viewModel?.dataArrayFoodWater.value[indexPath.row].picture)!)), placeholder:  UIImage(named: "image_defauft_medium"))
        cell.image_check.image = UIImage(named: self.viewModel?.dataArrayFoodWater.value[indexPath.row].isSelected == DEACTIVE ? "icon-check-enable":"check")
//        cell.btn_inscreament.rx.tap.asDriver().drive(onNext: {
//            data?.enumerated().forEach{
//                (index,value) in
//                if self.viewModel?.dataArrayFoodWater.value[indexPath.row].idfood == value.idfood {
//
//                    data![index].quantityRealTime += 1
//                    cell.lbl_number.text = String( data![index].quantityRealTime)
//                    self.viewModel?.dataArrayFoodWater.accept(data!)
//                }
//
//            }
//
//        })
//        cell.btn_descreament.rx.tap.asDriver().drive(onNext: {
//            data?.enumerated().forEach{
//                (index,value) in
//                if self.viewModel?.dataArrayFoodWater.value[indexPath.row].idfood == value.idfood && data![index].quantityRealTime > 1 {
//                    data![index].quantityRealTime -= 1
//                    cell.lbl_number.text = String( data![index].quantityRealTime)
//                    self.viewModel?.dataArrayFoodWater.accept(data!)
//                }
//            }
//
//        })
////        self.viewModel?.dataArrayFoodWater.accept(data!)
//        dLog(self.viewModel?.dataArrayFoodWater.value)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
