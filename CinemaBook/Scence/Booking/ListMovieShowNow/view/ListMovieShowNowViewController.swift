//
//  ListMovieShowNowViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa
import ObjectMapper

class ListMovieShowNowViewController: BaseViewController {

    var viewModel = ListMovieShowNowViewModel()
    var router = ListMovieShowNowRouter()
    var status = 0
    var Type_edit = 0
    var type_viewTralling = 0
    
    @IBOutlet weak var view_no_data: UIView!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var txt_search: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgisterCollection()
        binđDataTableCollectionView()
        txt_search.rx.controlEvent(.editingChanged)
             .withLatestFrom(txt_search.rx.text)
               .subscribe(onNext:{ [self] query in
                var cloneAreaDataFilter = self.viewModel.dataSearch.value
                   if !query!.isEmpty{
                       var filteredWarehouseMaterialList = cloneAreaDataFilter.filter({
                           (value) -> Bool in
                           let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                           let str2 = value.namemovie.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                           return str2.contains(str1)
                       })
                    self.viewModel.dataArray.accept(filteredWarehouseMaterialList)
                   }else{
                    self.viewModel.dataArray.accept(cloneAreaDataFilter)
                   }
        })
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var data = viewModel.allvalue.value
        data.status = status
        viewModel.allvalue.accept(data)
        getListmovie()
    }
 
    @IBAction func btn_showsearch(_ sender: Any) {
        view_search.isHidden = false
    }
    
    
    @IBAction func btn_close_search(_ sender: Any) {
        view_search.isHidden = true
    }
}
