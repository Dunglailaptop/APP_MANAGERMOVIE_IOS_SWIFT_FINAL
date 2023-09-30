//
//  CreateProductViewController + Extension.swift
//  CinemaBook
//
//  Created by dungtien on 9/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import MWPhotoBrowser
import ObjectMapper
import JonAlert

extension CreateProductViewController: UITableViewDelegate {
    func regiter() {
        let cellTable = UINib(nibName: "ItemFoodTableViewCell", bundle: .main)
        tableview.register(cellTable, forCellReuseIdentifier: "ItemFoodTableViewCell")
        tableview.separatorStyle = .none
        tableview.rx.setDelegate(self)
        tableview.rx.modelSelected(Food.self).subscribe(onNext: { [self] element in
            var data = self.viewModel.dataArray.value
            data.enumerated().forEach{ (index,value) in
             
                if value.idfood == element.idfood  {
                   
                    if value.isSelected == DEACTIVE {
                           data[index].isSelected = ACTIVE
                        self.Taglistview.addTag(value.namefood)
                    }else {
                         data[index].isSelected = DEACTIVE
                        self.Taglistview.removeTag(value.namefood)
                    }
                }
                
            }
            self.viewModel.dataArray.accept(data)
            
               })
    }
    func bindingtable() {
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "ItemFoodTableViewCell", cellType: ItemFoodTableViewCell.self)) {
            (row,data,cell) in
            cell.data = data
            
        }
    }
    

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
//CALL API
extension CreateProductViewController {
    func getListFood() {
        viewModel.getListFood().subscribe(onNext: {(response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Food>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArray.accept(data)
                    self.heighttable.constant = CGFloat(self.viewModel.dataArray.value.count * 50) + 10
                    self.height_Scroll.constant = self.heighttable.constant + 1000
                }
            }
        })
    }
    func createFoodCombo() {
        viewModel.createComboFood().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                JonAlert.showSuccess(message: "Thêm món combo thành công")
                self.viewModel.makePopToViewController()
            }else {
                JonAlert.showError(message: "Thêm món combo thất bại")
            }
        })
    }
}

extension CreateProductViewController: InputMoneyDelegate {
    func callBackInputMoney(amount:Int,position:Int) {
        var dataPrice = viewModel.dataMap.value
        dataPrice.priceCombo = amount
        viewModel.dataMap.accept(dataPrice)
        txt_number_price.text = Utils.stringVietnameseFormatWithNumber(amount: amount)
     }
    func presentModalInputMoneyViewController(current_money: Int) {
                let dialogInputMoneyViewController = DialogInputMoneyViewController()
                dialogInputMoneyViewController.minMoney = 1000
                dialogInputMoneyViewController.maxMoney = 999999999
                dialogInputMoneyViewController.current_money = current_money
                dialogInputMoneyViewController.delegate = self
                dialogInputMoneyViewController.view.backgroundColor = ColorUtils.blackTransparent()

                // 2
                let nav = UINavigationController(rootViewController: dialogInputMoneyViewController)
                nav.isNavigationBarHidden = true
                nav.modalPresentationStyle = .overCurrentContext
                  present(nav, animated: true, completion: nil)

        }

           
       
}
//CALL API
extension CreateProductViewController {
    func validate() {
            _ = txt_name.rx.text.map({(str) -> FoodCombo in
            var namefoods = self.viewModel.dataMap.value
            namefoods.nametittle = str ?? ""
            return namefoods
            }).bind(to: viewModel.dataMap)
            _ = txt_discription.rx.text.map({(str) -> FoodCombo in
            var namefoods = self.viewModel.dataMap.value
            namefoods.descriptions = str ?? ""
            return namefoods
            }).bind(to: viewModel.dataMap)
          
        
    }
}
extension CreateProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
               self.imagecover.append(selectedImage)
               
               // Lấy URL của ảnh đã chọn
               if let imageUrl = info[.imageURL] as? URL {
                   let imageName = imageUrl.lastPathComponent
                   dLog("Tên ảnh: \(imageName)")
                nameImage.append(imageName)
               }
           }
           picker.dismiss(animated: true, completion: nil)
       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
    
    func postUpdateWithAvatar(){
          var medias = [Medias]()
          var medias_request = Medias()
          var dataImage = viewModel.dataMap.value
          medias_request.image = imagecover[0]
          dLog(nameImage)
          
          medias_request.name = nameImage[0]
          medias.append(medias_request)
          viewModel.media_request.accept(medias)
          viewModel.uploadImage()
          let connectImage = nameImage[0] + "/" + nameImage[0];
           dataImage.picture = connectImage
          viewModel.dataMap.accept(dataImage)
          createFoodCombo()
         
        
      
      }
    
}

