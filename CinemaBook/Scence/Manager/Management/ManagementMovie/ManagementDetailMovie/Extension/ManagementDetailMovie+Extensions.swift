//
//  ManagementDetailMovie+Extensions.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 21/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import JonAlert

extension ManagementDetailMovieViewController: SambagDatePickerViewControllerDelegate {
    
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult){
        txt_dateShow.text = result.description
        var dataValueMovie = viewModel.valueMovie.value
        dataValueMovie.yearbirthday = Utils().convertFormartDateyearMMddToString(date: result.description)!
        viewModel.valueMovie.accept(dataValueMovie)
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

extension ManagementDetailMovieViewController: CaculatorInputQuantityDelegate {
    func presentModalInputQuantityViewController(position:Int, current_quantity:Float) {
        let quantityInputViewController = QuantityInputViewController()
        
        quantityInputViewController.current_quantity = current_quantity
        quantityInputViewController.max_quantity = 200
        quantityInputViewController.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: quantityInputViewController)
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
        quantityInputViewController.delegate_quantity = self
        quantityInputViewController.position = position
            present(nav, animated: true, completion: nil)

        }
    func callbackCaculatorInputQuantity(number: Float, position: Int) {
        let numbers = round(number)
        txt_time_show.text = String(Int(numbers)) + " Phút"
        var dataValueMovie = viewModel.valueMovie.value
        dataValueMovie.timeall = Int(number)
        viewModel.valueMovie.accept(dataValueMovie)
    }
}

extension ManagementDetailMovieViewController {
    func updatemovie() {
        viewModel.updateMovie().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Movie>().map(JSONObject: response.data) {
                    JonAlert.showSuccess(message: "Cập nhật phim thành công")
                    self.viewModel.makePopTovViewController()
                }
            }
            
        })
    }
    
    
    func createNewMovie() {
        viewModel.createNewMovie().subscribe(onNext:  {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Movie>().map(JSONObject: response.data)
                {
                    JonAlert.showSuccess(message: "Tạo phim mới thành công")
                    self.viewModel.valueMovie.accept(data)
                    self.viewModel.makePopTovViewController()
                }else {
                    JonAlert.showSuccess(message: "Tạo phim mới thất bại")
                }
            }
        })
    }
    
    func getDetailMovie() {
        viewModel.getDetailMovie().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Movie>().map(JSONObject: response.data) {
                    self.viewModel.valueMovie.accept(data)
                    self.setupvalid()
                }
            }

        })
    }
    
    func setupvalid() {
        txt_author.text = viewModel.valueMovie.value.author
        txt_namemovie.text = viewModel.valueMovie.value.namemovie
        txt_description.text = viewModel.valueMovie.value.describes
        txt_dropdown_nation.text = viewModel.valueMovie.value.namenation
        txt_drop_down_categoryMovie.text = viewModel.valueMovie.value.namecategorymovie
        txt_timeShow.text = String(viewModel.valueMovie.value.timeall)
        txt_dateShow.text = viewModel.valueMovie.value.yearbirthday
        txt_idmovie.text = String(viewModel.valueMovie.value.movieID)
        image_poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: viewModel.valueMovie.value.poster)), placeholder:  UIImage(named: "image_defauft_medium"))
    }
    
    
    func getListNation() {
        viewModel.getListNation().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Nation>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArrayNation.accept(data)
                    self.txt_dropdown_nation.optionArray = data.map{ $0.namenation}
                    self.txt_dropdown_nation.optionIds = data.map{$0.idnation}
                    self.getListCategoryMovie()
                }
            }
        })
    }
    
    func getListCategoryMovie() {
        viewModel.getListCategortMovie().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<CategoryMovie>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArrayMovie.accept(data)
                    self.txt_drop_down_categoryMovie.optionArray = data.map{ $0.namecategorymovie}
                    self.txt_drop_down_categoryMovie.optionIds = data.map{$0.idcategorymovie}
                    
                }
            }
        })
    }
    
    func postUpdateWithAvatar(){
        var medias = [Medias]()
        var medias_request = Medias()
        var dataImage = viewModel.valueMovie.value
        medias_request.image = imagecover[0]
        dLog(nameImage)
        
        medias_request.name = nameImage[0]
        medias.append(medias_request)
        viewModel.media_request.accept(medias)
        viewModel.uploadImage()
        let connectImage = nameImage[0] + "/" + nameImage[0];
         dataImage.poster = connectImage
        viewModel.valueMovie.accept(dataImage)
     
     
        if  type_check == "CREATE" {
            createNewMovie()
        } else  {
             updatemovie()
        }
    
    }
}
extension ManagementDetailMovieViewController {
    func setup() {
        btn_dropdowncategorymovie.rx.tap.asDriver().drive(onNext: {
            [self] value in
            txt_drop_down_categoryMovie.showList()
        })
        btn_dropdown_nation.rx.tap.asDriver().drive(onNext: {
            [self] value in
            txt_dropdown_nation.showList()
        })
        
        txt_dropdown_nation.didSelect{ [self](selectedText , index ,id) in
            txt_dropdown_nation.text = selectedText
            var cloneAPIParameter = viewModel.valueMovie.value
            cloneAPIParameter.idnation = id
            viewModel.valueMovie.accept(cloneAPIParameter)
        }
        txt_drop_down_categoryMovie.didSelect{ [self](selectedText , index ,id) in
            txt_drop_down_categoryMovie.text = selectedText
            var cloneAPIParameter = viewModel.valueMovie.value
            cloneAPIParameter.idcategory = id
            viewModel.valueMovie.accept(cloneAPIParameter)
        }
        
        
        _ = txt_namemovie.rx.text.map{(str) in
            if str!.count > 50 {
                JonAlert.showError(message: "Tối tên phim 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Movie in
            self.txt_namemovie.text = str
            var cloneEmployeeInfor = self.viewModel.valueMovie.value
            cloneEmployeeInfor.namemovie = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.valueMovie)
        
        
        _ = txt_description.rx.text.map{(str) in
            if str!.count > 50 {
                JonAlert.showError(message: "Tối mô tả tối đa 255 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Movie in
            self.txt_description.text = str
            var cloneEmployeeInfor = self.viewModel.valueMovie.value
            cloneEmployeeInfor.describes = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.valueMovie)
        
        _ = txt_author.rx.text.map{(str) in
            if str!.count > 50 {
                JonAlert.showError(message: "Tối tên tác giả 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Movie in
            self.txt_author.text = str
            var cloneEmployeeInfor = self.viewModel.valueMovie.value
            cloneEmployeeInfor.author = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.valueMovie)
    }
    
    private func validate(){
        _ = isNameValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_nameMovie.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isAuthorValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_author.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isDesciption.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_description.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isTimeall.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_alltime.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isDateTime.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_dateShowMovie.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isCategoryMovie.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_categoryovie.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        _ = isNation.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_nation.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
    }
    
  
    
    var isEmployeeInforValid: Observable<Bool>{
        return Observable.combineLatest(isNameValid,isAuthorValid,isDesciption,isNation,isDesciption, isCategoryMovie,isDateTime,isTimeall){$0 && $1 && $2 && $3 && $4 && $5 && $6 && $7}
    }
    
    
    private var isNameValid: Observable<Bool>{
        return viewModel.valueMovie.map{$0.namemovie}.distinctUntilChanged().asObservable().map(){[self] (str) in
            let name = str.trim()
            lbl_error_nameMovie.isHidden = false
            
            if name.count < 2{
                lbl_error_nameMovie.text = "Độ dài tối thiểu 2 ký tự"
                return false
            }

            lbl_error_nameMovie.isHidden = true
            lbl_error_nameMovie.text = ""
            return true
        }

    }
    
    
    private var isAuthorValid:Observable<Bool>{
        
        return viewModel.valueMovie.map{$0.author}.distinctUntilChanged().asObservable().map(){[self](str) in
            let id = str.trim()
            lbl_error_author.isHidden = false
            
            if(id.count < 9){
                lbl_error_author.text = "Độ dài tối thiếu 9 ký tự"
                return false
            }

            lbl_error_author.isHidden = true
            lbl_error_author.text = ""
            return true
        }
    }
    
    private var isDesciption:Observable<Bool>{
        
        return viewModel.valueMovie.map{$0.describes}.distinctUntilChanged().asObservable().map(){[self](str) in
          
            lbl_error_description.isHidden = false
            
            if(str.count <= 0){
                lbl_error_description.text = "Độ dài tối đa 255 ký tự vả tối thiểu là 10 ký tự"
                return false
            }

            lbl_error_description.isHidden = true
            lbl_error_description.text = ""
            return true
        }
    }
    
    private var isTimeall:Observable<Bool>{
        
        return viewModel.valueMovie.map{$0.timeall}.distinctUntilChanged().asObservable().map(){[self](id) in

            lbl_error_alltime.isHidden = false
            
            if(id <= 0){
                lbl_error_alltime.text = "Vui lòng nhập tổng thời gian chiếu"
                return false
            }

            lbl_error_alltime.isHidden = true
            lbl_error_alltime.text = ""
            return true
        }
    }
        
    private var isDateTime:Observable<Bool>{
        
        return viewModel.valueMovie.map{$0.yearbirthday}.distinctUntilChanged().asObservable().map(){[self](str) in
            let id = str.trim()
            lbl_error_dateShowMovie.isHidden = false
            
            if(id.count <= 0){
                lbl_error_dateShowMovie.text = "Vui lòng chọn ngày chiếu"
                return false
            }

            lbl_error_dateShowMovie.isHidden = true
            lbl_error_dateShowMovie.text = ""
            return true
        }
    }
    
  
    
    private var isCategoryMovie:Observable<Bool>{
        return viewModel.valueMovie.map{$0.idcategory}.distinctUntilChanged().asObservable().map(){[self](id) in

            lbl_error_categoryovie.isHidden = false
            if id <= 0{
                lbl_error_categoryovie.text = "Vui lòng chọn loại phim"
                return false
            }
            lbl_error_categoryovie.isHidden = true
            lbl_error_categoryovie.text = ""
            return true
        }
    }
    
    private var isNation:Observable<Bool>{
        return viewModel.valueMovie.map{$0.idnation}.distinctUntilChanged().asObservable().map(){[self](id) in

            lbl_error_nation.isHidden = false
            if id <= 0{
                lbl_error_nation.text = "Vui lòng chọn quốc gia"
                return false
            }
            lbl_error_nation.isHidden = true
            lbl_error_nation.text = ""
            return true
        }
    }
    
  
}
extension ManagementDetailMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     @objc func openPhotoLibrary() {
           let imagePicker = UIImagePickerController()
           imagePicker.sourceType = .photoLibrary
           imagePicker.delegate = self
           present(imagePicker, animated: true, completion: nil)
       
       }
       
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
               // Lưu ảnh đã chọn vào biến imageView
               image_poster.image = selectedImage
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
}
