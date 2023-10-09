//
//  ChatMessageViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class ChatMessageViewController: BaseViewController {

    var viewModel = ChatMessageViewModel()
    var router = ChatMessageRouter()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgister()
        bindingtableview()
        // Do any additional setup after loading the view.
    }


  

}
extension ChatMessageViewController: UITableViewDelegate {
    func resgister() {
        let celltableItemchat = UINib(nibName: "ItemChatTableViewCell", bundle: .none)
        tableView.register(celltableItemchat, forCellReuseIdentifier: "ItemChatTableViewCell")
        
        tableView.separatorStyle = .none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        tableView.rx.modelSelected(Int.self).subscribe(onNext: {
            element in
            let views = MessageViewController()
            self.navigationController?.pushViewController(views, animated: true)
        })
    }
    
    func bindingtableview(){
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ItemChatTableViewCell", cellType: ItemChatTableViewCell.self)) {
            (row,data,cell) in
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
