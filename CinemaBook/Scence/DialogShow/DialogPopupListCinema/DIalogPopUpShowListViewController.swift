//
//  DIalogPopUpShowListViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 11/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import ObjectMapper
import iOSDropDown

class DIalogPopUpShowListViewController: UIViewController {
    
    
    @IBOutlet weak var btn_show_dropdown: UIButton!
    
    @IBOutlet weak var txt_dropdown_listcinema: DropDown!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     setup()
        
    }

   
    @IBAction func btn_access(_ sender: Any) {
        dismiss(animated: true)
    }
    
    var viewModel: StoreViewModel? = nil {
        didSet{
            getListCinema()
            
        }
    }
    func setup(){
        txt_dropdown_listcinema.didSelect(completion: {
            [self] (selectedText,index,id) in
            txt_dropdown_listcinema.text = selectedText
        })
        
        btn_show_dropdown.rx.tap.asDriver().drive(onNext:{
            [self]
            self.txt_dropdown_listcinema.showList()
        }
        )
    }
    
}
extension DIalogPopUpShowListViewController {
    func getListCinema(){
        viewModel?.getListCinema().subscribe(onNext: {
            [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Cinema>().mapArray(JSONObject: response.data) {
                    dLog(data)
                    txt_dropdown_listcinema.optionArray = data.map{$0.namecinema}
                    txt_dropdown_listcinema.optionIds = data.map{$0.idcinema}
                }
            }else
            {
                
            }
        })
    }
}
