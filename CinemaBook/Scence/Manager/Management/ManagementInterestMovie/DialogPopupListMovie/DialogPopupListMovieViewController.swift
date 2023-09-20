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
   
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       register()
        bindingtableviewcell()
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
    }
    func bindingtableviewcell(){
        viewModel.dataArrayMovie.bind(to: tableView.rx.items(cellIdentifier: "ItemMovieInterestManagementTableViewCell", cellType: ItemMovieInterestManagementTableViewCell.self)){
            (row,data,cell) in
            cell.data = data
            cell.btn_button_check.rx.tap.asDriver().drive(onNext: {
                var datas = self.viewModel.dataArrayMovie.value
                var dataselected = self.viewModel.selectedDataMovie.value
                datas.enumerated().forEach {(index,value) in
                   if(cell.data?.movieID == value.movieID){
                        datas[index].ischeck = cell.data?.ischeck == 1 ? 0 : 1
                    }
                }
                if data.ischeck == 1 {
                    dataselected.append(data)
                                 self.viewModel.selectedDataMovie.accept(dataselected)
                }
             
                self.viewModel.dataArrayMovie.accept(datas)
            
            })
        }
    }
}
extension DialogPopupListMovieViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}