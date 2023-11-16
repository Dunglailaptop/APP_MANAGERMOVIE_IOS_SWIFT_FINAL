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
    
    @IBOutlet weak var btn_close_sreach: UIButton!
    @IBOutlet weak var lbl_date_to: UILabel!
    @IBOutlet weak var lbl_date_From: UILabel!
    @IBOutlet weak var view_no_data: UIView!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var txt_search: UITextField!
    var type_choose_date = 0
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
        if Type_edit == 0 {
            view_search.isHidden = false
            btn_close_sreach.isUserInteractionEnabled = false
            var data = viewModel.allvalue.value
            data.status = status
            viewModel.allvalue.accept(data)
            getListMovieBooking()
        } else
        {
            view_search.isHidden = true
            var data = viewModel.allvalue.value
            data.status = status
            viewModel.allvalue.accept(data)
            getListmovie()
        }
      
    }
 
    @IBAction func btn_showsearch(_ sender: Any) {
        view_search.isHidden = false
    }
    
    
    @IBAction func btn_close_search(_ sender: Any) {
        view_search.isHidden = true
    }
    
    @IBAction func btn_showlistcategoryMovie(_ sender: Any) {
     presentDialogCategoryMovie()
    }
    
    @IBAction func btn_showDateFrom(_ sender: Any) {
        type_choose_date = 0
        showDateTimePicker(dataDateTime: Utils.getCurrentDateString())
    }
    
    @IBAction func btn_showdateTO(_ sender: Any) {
        type_choose_date = 1
        showDateTimePicker(dataDateTime: Utils.getCurrentDateString())
    }
    
    
}
extension ListMovieShowNowViewController: DialogChooseCategoryMovie {
    func callbackChooseCategoryMovie(Idcategory: Int) {
        var data = viewModel.allvalue.value
        data.Idcategory = Idcategory
        viewModel.allvalue.accept(data)
        getListmovie()
        dismiss(animated: true)
    }
    
    func presentDialogCategoryMovie() {
        let DialogChooseCategoryMovieViewControllers = DialogChooseCategoryMovieViewController()
        DialogChooseCategoryMovieViewControllers.viewModel = self.viewModel
        DialogChooseCategoryMovieViewControllers.delegate = self
        DialogChooseCategoryMovieViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: DialogChooseCategoryMovieViewControllers)
            // 1
        nav.modalPresentationStyle = .overCurrentContext

            
            // 2
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    
                    // 3
                    sheet.detents = [.large()]
                    
                }
            } else {
                // Fallback on earlier versions
            }
            // 4
     
            present(nav, animated: true, completion: nil)

        }
}
