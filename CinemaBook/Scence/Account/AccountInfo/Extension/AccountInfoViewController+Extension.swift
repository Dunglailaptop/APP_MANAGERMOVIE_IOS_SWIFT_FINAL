//
//  AccountInfoViewController+Extension.swift
//  CinemaBook
//
//  Created by dungtien on 9/3/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension AccountInfoViewController {
    func checkvaliad() {
        _ = txt_username.rx.text.map{String($0!.prefix(50))}.map({ (str) -> Users in
            self.txt_username.text = str
            var clonedata = self.viewModel.dataArray.value
            clonedata.fullname = str
            return clonedata
        }).bind(to: viewModel.dataArray)
        _ = txt_phone.rx.text.map{String($0!.prefix(10))}.map({(str) -> Users in
            self.txt_phone.text = str
            var clonedata = self.viewModel.dataArray.value
            clonedata.phone = str
            return clonedata
        }).bind(to: viewModel.dataArray)
        _ = txt_email.rx.text.map{String($0!.prefix(20))}.map({(str) -> Users in
            self.txt_email.text = str
            var clonedata = self.viewModel.dataArray.value
            clonedata.email = str
            return clonedata
        }).bind(to: viewModel.dataArray)
        
    }
    
}
extension AccountInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     @objc func openPhotoLibrary() {
           let imagePicker = UIImagePickerController()
           imagePicker.sourceType = .photoLibrary
           imagePicker.delegate = self
           present(imagePicker, animated: true, completion: nil)
       
       }
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let selectedImage = info[.originalImage] as? UIImage {
               // Lưu ảnh đã chọn vào biến imageView
               avatar.image = selectedImage
           }
           picker.dismiss(animated: true, completion: nil)
       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}
extension AccountInfoViewController: SambagDatePickerViewControllerDelegate {
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult){
        txt_birthday.text = result.description
        viewController.dismiss(animated: true, completion: nil)
     }
     
     func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
         viewController.dismiss(animated: true, completion: nil)
     }
     
     func showDateTimePicker(dateTimeData:String){

         let vc = SambagDatePickerViewController()
         var limit = SambagSelectionLimit()
         
         var dateNow = Date()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd/MM/yyyy"
         dateNow = dateFormatter.date(from: dateTimeData) ?? dateNow
         limit.selectedDate = dateNow

         // Set the minimum and maximum selectable dates
         let calendar = Calendar.current
         let currentDate = Date()
         let minDate = calendar.date(byAdding: .year, value: -1000, to: currentDate) // One year ago
         let maxDate = calendar.date(byAdding: .year, value: 1000, to: currentDate) // One year from now

         limit.minDate = minDate
         limit.maxDate = maxDate
         vc.limit = limit
         vc.delegate = self
         present(vc, animated: true, completion: nil)
        }
}
