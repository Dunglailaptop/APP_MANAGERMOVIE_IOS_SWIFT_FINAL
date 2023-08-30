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

class ListCinemaTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    var rxbag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: TimeShowViewModel? = nil {
        didSet {
            register()
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
            
            
//            cell.btn_show_all.rx.tap.asDriver().drive(onNext: { [weak self] in
//                if cell.view_height.constant == 0 {
//                    cell.icon_dropdown.image = UIImage(named: "see_more")
//                    self!.viewModel?.heightforcell.accept(80)
//                    cell.view_height.constant = 25
//                    self?.tableView.rowHeight = 80
//                } else {
//                    cell.icon_dropdown.image = UIImage(named: "see_less")
//                    self!.viewModel?.heightforcell.accept(70)
//                    cell.view_height.constant = 0
//                    self?.tableView.rowHeight = 70
//                }
//
//            }).disposed(by: self.rxbag)
            
        }
    }
}
extension ListCinemaTableViewCell: UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80

           }
}
