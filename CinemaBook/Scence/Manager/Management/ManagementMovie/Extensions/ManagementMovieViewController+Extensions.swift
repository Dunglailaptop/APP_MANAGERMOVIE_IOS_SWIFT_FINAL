//
//  ManagementMovieViewController+Extensions.swift
//  CinemaBook
//
//  Created by dungtien on 9/15/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import JonAlert
import ObjectMapper


extension ManagementMovieViewController {
    func getListMovie() {
        viewModel.getListMovie().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Movie>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                }
                
            }else {
                JonAlert.showError(message: "Có lỗi trong quá trình kết nối")
            }
            
            }).disposed(by: rxbag)
    }
}
extension ManagementMovieViewController {
    func presentDialogCategoryMovie() {
        let DialogChooseCategoryMovieViewControllers = DialogChooseCategoryMovieViewController()
        
     
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
