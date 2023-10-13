//
//  ItemFoodUnWaterSectionTableViewCell.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 12/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class ItemFoodUnWaterSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellFoodCombocell = UINib(nibName: "ItemDialogFoodCommboTableViewCell", bundle: .main)
        tableView.register(cellFoodCombocell, forCellReuseIdentifier: "ItemDialogFoodCommboTableViewCell")
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
extension ItemFoodUnWaterSectionTableViewCell: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataArrayfood.value.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data = self.viewModel?.dataArrayfood.value
        data?.enumerated().forEach{
            (index,value) in
            if value.idfood == viewModel?.dataArrayfood.value[indexPath.row].idfood && value.isSelected == DEACTIVE {
                data![index].isSelected = ACTIVE
            }else if viewModel!.dataArrayfood.value.filter{$0.isSelected == ACTIVE}.count > 0  {
                data![index].isSelected = DEACTIVE
            }
             
            
            
        }
        self.viewModel?.dataArrayfood.accept(data!)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDialogFoodCommboTableViewCell", for: indexPath) as! ItemDialogFoodCommboTableViewCell
        cell.selectionStyle = .none
        cell.lbl_name_food.text = viewModel?.dataArrayfood.value[indexPath.row].namefood
        cell.icon_check.image = UIImage(named: self.viewModel?.dataArrayfood.value[indexPath.row].isSelected == ACTIVE ? "check_2" : "icon-check-disable")
//        cell.btn_check.rx.tap.asDriver().drive(onNext: {
//           
//         
//           
//        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
