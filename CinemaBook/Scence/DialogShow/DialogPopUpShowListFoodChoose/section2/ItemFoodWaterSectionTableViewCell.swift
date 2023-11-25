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
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataArrayFoodWater.value.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDialogFoodComboWaterTableViewCell", for: indexPath) as! ItemDialogFoodComboWaterTableViewCell
        cell.lbl_name_food.text = viewModel?.dataArrayFoodWater.value[indexPath.row].namefood
        cell.lbl_number.text = String(viewModel!.dataArrayFoodWater.value[indexPath.row].quantityRealTime)
        var data = viewModel?.dataArrayFoodWater.value
        cell.image_view.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: (viewModel?.dataArrayFoodWater.value[indexPath.row].picture)!)), placeholder:  UIImage(named: "image_defauft_medium"))
        cell.btn_inscreament.rx.tap.asDriver().drive(onNext: {
            data?.enumerated().forEach{
                (index,value) in
                if self.viewModel?.dataArrayFoodWater.value[indexPath.row].idfood == value.idfood {
                   
                    data![index].quantityRealTime += 1
                    cell.lbl_number.text = String( data![index].quantityRealTime)
                }
                
            }
          
        })
        cell.btn_descreament.rx.tap.asDriver().drive(onNext: {
            data?.enumerated().forEach{
                (index,value) in
                if self.viewModel?.dataArrayFoodWater.value[indexPath.row].idfood == value.idfood && data![index].quantityRealTime > 1 {
                    data![index].quantityRealTime -= 1
                    cell.lbl_number.text = String( data![index].quantityRealTime)
                }
            }
          
        })
        self.viewModel?.dataArrayFoodWater.accept(data!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
