//
//  BannerDataThreeTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/8/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BannerDataThreeTableViewCell: UITableViewCell {

     private(set) var disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
          register()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: HomeViewModel? {
        didSet{
          
            bindingtable()
        }
    }
    
}
extension BannerDataThreeTableViewCell {
    func register() {
        let viewCollection1 = UINib(nibName: "BannerVoucherTableViewCell", bundle: .main)
        tableView.register(viewCollection1, forCellReuseIdentifier: "BannerVoucherTableViewCell")
        let viewCollection2 = UINib(nibName: "BannerProductTableViewCell", bundle: .main)
              tableView.register(viewCollection2, forCellReuseIdentifier: "BannerProductTableViewCell")
        let viewCollection3 = UINib(nibName: "BannerTraillerVideoTableViewCell", bundle: .main)
              tableView.register(viewCollection3, forCellReuseIdentifier: "BannerTraillerVideoTableViewCell")
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
      func bindingtable() {
          viewModel?.dataArrayProduct.bind(to: tableView.rx.items)
          { [self]  (tableView, index, element) -> UITableViewCell in
              let indexPath = IndexPath(row: index, section: 0)
              switch index {
              case 0:
                  let cell = self.tableView.dequeueReusableCell(withIdentifier: "BannerVoucherTableViewCell", for: indexPath) as! BannerVoucherTableViewCell
                                              
                  cell.viewModel = self.viewModel
                                              cell.selectionStyle = .none
                  
                  return cell
              case 1:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "BannerTraillerVideoTableViewCell", for: indexPath) as! BannerTraillerVideoTableViewCell
                cell.viewModel = self.viewModel
                    cell.selectionStyle = .none
                    return cell
               
               case 2:
                   let cell = self.tableView.dequeueReusableCell(withIdentifier: "BannerProductTableViewCell", for: indexPath) as! BannerProductTableViewCell
                    cell.viewModel = self.viewModel
                    cell.selectionStyle = .none
                                  
                    return cell
              default:
                  let cell = self.tableView.dequeueReusableCell(withIdentifier: "BannerTraillerVideoTableViewCell", for: indexPath) as! BannerTraillerVideoTableViewCell
                   
                  cell.selectionStyle = .none
                  return cell
              }


              }.disposed(by: disposeBag)
      }
}
extension BannerDataThreeTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
