//
//  ListCinemaTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 8/28/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class ListCinemaTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    var rxbag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
         register()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: TimeShowViewModel? = nil {
        didSet {
           
            bindingtableview()
            
        }
    }
    
}
extension ListCinemaTableViewCell {
    
    
    func register() {
        let itemCinemaviewcell = UINib(nibName: "ItemCinemaTableViewCell", bundle: .main)
        tableView.register(itemCinemaviewcell, forCellReuseIdentifier: "ItemCinemaTableViewCell")
        self.tableView.estimatedRowHeight = 80
                      self.tableView.rowHeight = UITableView.automaticDimension
                      tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
    }
    
    func bindingtableview() {
        viewModel?.dataListCinema.bind(to: tableView.rx.items(cellIdentifier: "ItemCinemaTableViewCell", cellType: ItemCinemaTableViewCell.self)) { (index, data, cell) in
            cell.viewModel = self.viewModel
//            cell.data = data
//            dLog(self.viewModel?.dataListCinema.value.count)

            
        }.disposed(by: rxbag)
    }
}
extension ListCinemaTableViewCell: UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80

           }
}
