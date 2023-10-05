//
//  DialogPopupListMovieViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/18/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import RxCocoa

class DialogPopupListMovieViewController: UIViewController {

    var viewModel = ManagementInterestMovieViewModel()
    var delagate: DialogListPopupInterestMovie?
   
    @IBOutlet weak var text_field_search: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       register()
        bindingtableviewcell()
        text_field_search.rx.controlEvent(.editingChanged)
             .withLatestFrom(text_field_search.rx.text)
               .subscribe(onNext:{ [self] query in
                var cloneAreaDataFilter = self.viewModel.dataArrayMovie.value
                  var dataAll = self.viewModel.dataSearchMovie.value
                if self.viewModel.dataSearchMovieHistory.value.count == 0 {
                  
                    self.viewModel.dataSearchMovieHistory.accept(cloneAreaDataFilter)
                }else {
                    var dataCheckHistry = self.viewModel.dataSearchMovieHistory.value
                    dataCheckHistry.enumerated().forEach{ (index,value) in
                        dataAll.enumerated().forEach{ (index1,value1) in
                            if value.movieID == value1.movieID && value.ischeck == 1 {
                                dataAll[index1].ischeck = 1
                            }
                        }
                    }
                }
             
               
                   if !query!.isEmpty{
                       var filteredWarehouseMaterialList = cloneAreaDataFilter.filter({
                           (value) -> Bool in
                           let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                           let str2 = value.namemovie.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                           return str2.contains(str1)
                       })
                    self.viewModel.dataArrayMovie.accept(filteredWarehouseMaterialList)
                   }else{
                    self.viewModel.dataArrayMovie.accept(dataAll)
                   }
        })
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListMovie()
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                      UIViewController.attemptRotationToDeviceOrientation()
    }

     // Cho phép xoay cả hai hướng
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .landscape
        }


         override var shouldAutorotate: Bool {
             return true
         }

         override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
             return .landscapeRight
         }

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_access(_ sender: Any) {
        var data = viewModel.dataArrayMovie.value.filter{ $0.ischeck == 1}
        delagate!.callbackDialogListMovie(Movies: data)
    }
}

extension DialogPopupListMovieViewController {
    func getListMovie() {
        viewModel.getListMovieShow().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Movie>().mapArray(JSONObject: response.data)
                {
                    self.viewModel.dataArrayMovie.accept(data)
                    self.viewModel.dataSearchMovie.accept(data)
                }
            }
        })
    }
}
extension DialogPopupListMovieViewController {
    func register(){
        let Tableviewcell = UINib(nibName: "ItemMovieInterestManagementTableViewCell", bundle: .main)
        tableView.register(Tableviewcell, forCellReuseIdentifier: "ItemMovieInterestManagementTableViewCell")
          
           tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self)
          tableView.rx.modelSelected(Movie.self).subscribe(onNext: { [self] element in
                                var datas = self.viewModel.dataArrayMovie.value
                                var dataselected = self.viewModel.selectedDataMovie.value
                                var dataCheckHistory = self.viewModel.dataSearchMovieHistory.value
                                datas.enumerated().forEach {(index,value) in
                                if(element.movieID == value.movieID){
                                datas[index].ischeck = element.ischeck == 1 ? 0 : 1
                                    }
                                  }
                                dataCheckHistory.enumerated().forEach {(index,value) in
                                if(element.movieID == value.movieID){
                                dataCheckHistory[index].ischeck = element.ischeck == 1 ? 0 : 1
                                    }
                                 }
            
                                if element.ischeck == 1 {
                                dataselected.append(element)
                                         self.viewModel.selectedDataMovie.accept(dataselected)
                                }

                                self.viewModel.dataArrayMovie.accept(datas)
                              self.viewModel.dataSearchMovieHistory.accept(dataCheckHistory)
             })
    }
    func bindingtableviewcell(){
        viewModel.dataArrayMovie.bind(to: tableView.rx.items(cellIdentifier: "ItemMovieInterestManagementTableViewCell", cellType: ItemMovieInterestManagementTableViewCell.self)){
            (row,data,cell) in
            cell.data = data
           
        }
    }
}
extension DialogPopupListMovieViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
