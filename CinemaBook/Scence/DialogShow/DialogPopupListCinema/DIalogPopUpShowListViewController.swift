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
import FSCalendar

class DIalogPopUpShowListViewController: UIViewController {
    
    @IBOutlet weak var clander_date_order: FSCalendar!
    
    @IBOutlet weak var btn_show_dropdown: UIButton!
    
    @IBOutlet weak var txt_dropdown_listcinema: DropDown!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     setup()
        clander_date_order.delegate = self
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
            viewModel?.idcinema.accept(id)
            viewModel?.namecinema.accept(selectedText)
            viewModel?.view?.lbl_name_cinema.text = "Rạp nhận: " + selectedText
        })
        
        btn_show_dropdown.rx.tap.asDriver().drive(onNext:{
            [self]
            self.txt_dropdown_listcinema.showList()
        }
        )
    }
    
}
extension DIalogPopUpShowListViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy-MM-dd" // Format the date as per your requirement
         let selectedDate = formatter.string(from: date)
         print("Selected date: \(selectedDate)")
        viewModel?.dateoreder.accept(selectedDate)
         // You can perform further actions with the selected date here
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
