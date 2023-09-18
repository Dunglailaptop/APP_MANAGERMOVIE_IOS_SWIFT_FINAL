//
//  DialogPopupListRoomViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/18/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class DialogPopupListRoomViewController: UIViewController {

    var viewModel = ManagementInterestMovieViewModel()
    var delegate: DialogListPopupInterestRoom?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        bindingtableview()
      UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                           UIViewController.attemptRotationToDeviceOrientation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var data = viewModel.allvalue.value
        data.idcinema = ManageCacheObject.getCurrentCinema().idcinema
        viewModel.allvalue.accept(data)
        self.getListRoom()
        
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
        let data = viewModel.selectedDataRoom.value.filter{$0.ischeck == 1}
        delegate?.callbackDialogListRoom(Rooms: data)
    }
}
extension DialogPopupListRoomViewController {
    func getListRoom(){
        viewModel.getListRoom().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Room>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArrayRoom.accept(data)
                }
            }
        })
    }
}

extension DialogPopupListRoomViewController{
    func register(){
        let Tableviewcell = UINib(nibName: "itemRoomInterestManagementTableViewCell", bundle: .main)
        tableView.register(Tableviewcell, forCellReuseIdentifier: "itemRoomInterestManagementTableViewCell")
        tableView.separatorStyle = .none
        tableView.rx.setDelegate(self)
    }
    func bindingtableview(){
        viewModel.dataArrayRoom.bind(to: tableView.rx.items(cellIdentifier: "itemRoomInterestManagementTableViewCell", cellType: itemRoomInterestManagementTableViewCell.self)){
            (row,data,cell) in
            cell.data = data
            cell.btn_check.rx.tap.asDriver().drive(onNext: {
                [self] in
                var dataArray = self.viewModel.dataArrayRoom.value ?? []
                dataArray.enumerated().forEach {(index,value) in
                    dataArray[index].ischeck = cell.data?.ischeck == 0 ? 1:0
                }
                self.viewModel.dataArrayRoom.accept(dataArray)
                
            })
            
        }
    }
}
extension DialogPopupListRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
