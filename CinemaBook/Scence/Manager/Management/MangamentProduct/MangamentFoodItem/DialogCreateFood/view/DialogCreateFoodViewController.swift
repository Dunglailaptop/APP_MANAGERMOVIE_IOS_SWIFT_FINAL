//
//  DialogCreateFoodViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 28/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import Photos
import JonAlert
import RxSwift
import RxCocoa
import RxRelay
import iOSDropDown
import ObjectMapper

class DialogCreateFoodViewController: BaseViewController {

    @IBOutlet weak var view_all: UIView!
    
    @IBOutlet weak var btn_tittle_access: UIButton!
    @IBOutlet weak var lbl_tittle: UILabel!
    @IBOutlet weak var txt_dropdownlistcategory: DropDown!
    @IBOutlet weak var lbl_error_number: UILabel!
    @IBOutlet weak var lbl_price_food: UILabel!
    @IBOutlet weak var lbl_error_categoryfood: UILabel!
    @IBOutlet weak var lbl_error_namefood: UILabel!
    @IBOutlet weak var view_button: UIView!
    
    @IBOutlet weak var txt_number: UITextField!
    @IBOutlet weak var txt_price: UITextField!
    @IBOutlet weak var image_food: UIImageView!
    @IBOutlet weak var txt_name_food: UITextField!
    @IBOutlet weak var btn_showdropdown: UIButton!
        var imagecover = [UIImage]()
        var selectedAssets = [PHAsset]()
        var nameImage: [String] = []
        var imageAvatarFireBase = UIImage()
        var idfood = 0
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        view_all.roundCorners([.topLeft,.topRight], radius: 20)
//        view_button.roundCorners([.topLeft,.topRight], radius: 10)
        setup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch type {
        case "CREATE":
            lbl_tittle.text = "TẠO MÓN ĂN"
            btn_tittle_access.setTitle("TẠO MỚI", for: .normal)
            
        case "DETAIL":
            lbl_tittle.text = "THÔNG TIN MÓN ĂN"
            btn_tittle_access.setTitle("CẬP NHẬT", for: .normal)
            var data = viewModel?.datafood.value
            data?.idfood = idfood
            viewModel?.datafood.accept(data!)
            getDetail()
        default:
            return
        }
        getListCategory()
    }


    @IBAction func btn_show_avatar(_ sender: Any) {
        openPhotoLibrary()
    }
    
    @IBAction func btn_show_price(_ sender: Any) {
        presentModalCaculatorInputMoneyViewController()
    }
    
    @IBAction func btn_quantity_food(_ sender: Any) {
        presentModalInputQuantityViewController(number: 100)
    }
    
    @IBAction func btn_number_food(_ sender: Any) {
        if let money = self.txt_number.text?.trim().replacingOccurrences(of: ",", with: ""){
            presentModalInputQuantityViewController(number: Float(money)!)
        }
       
    }
    
    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_create_food(_ sender: Any) {
        isEmployeeInforValid.take(1).subscribe(onNext: {
            [self] isValid in
            if isValid {
                switch type {
                case "CREATE":
                    imagecover.count > 0 ? postUpdateWithAvatar():createfood()
                case "DETAIL":
                    imagecover.count > 0 ? postUpdateWithAvatar():updateinfoFood()
                default:
                    return
                }
               
            }
        }).disposed(by: rxbag)
    }
    
    var viewModel: MangamentFoodItemViewModel? = nil {
        didSet {
            
        }
    }
    
 
}

extension DialogCreateFoodViewController {
    func postUpdateWithAvatar(){
        var medias = [Medias]()
        var medias_request = Medias()
        var dataImage = viewModel?.datafood.value
        medias_request.image = imagecover[0]
        dLog(nameImage)
        
        medias_request.name = nameImage[0]
        medias.append(medias_request)
        viewModel?.media_request.accept(medias)
        viewModel?.uploadImage()
        let connectImage = nameImage[0] + "/" + nameImage[0];
        dataImage?.picture = connectImage
        viewModel?.datafood.accept(dataImage!)
     
        switch type {
        case "CREATE":
            createfood()
        case "DETAIL":
            updateinfoFood()
        default:
            return
        }
      
    
    }
    
    func updateinfoFood() {
        viewModel?.updateinfofood().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Food>().map(JSONObject: response.data) {
                    JonAlert.showSuccess(message: "Cập nhật thông tin món ăn thành công")
                    self.viewModel?.view?.getListFood()
                    self.dismiss(animated: true)
                }
            }
        })
    }
    
    
    func getDetail() {
        viewModel?.getDetailFood().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Food>().map(JSONObject: response.data) {
                    self.viewModel?.datafood.accept(data)
                    self.txt_name_food.text = data.namefood
                    self.txt_price.text = Utils.stringVietnameseFormatWithNumber(amount: data.pricefood)
                    self.txt_number.text = String(data.quantityfood)
                    self.txt_dropdownlistcategory.text = data.namecategoryfood
                    self.image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data.picture)), placeholder:  UIImage(named: "image_defauft_medium"))
                }
            }
        })
    }
    
    func getListCategory() {
        viewModel?.getListCategoryFood().subscribe(onNext: { [self]
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<CategoryFood>().mapArray(JSONObject: response.data) {
                    viewModel?.datacategoryfood.accept(data)
                    txt_dropdownlistcategory.optionArray = data.map{$0.namecategoryfood}
                    txt_dropdownlistcategory.optionIds = data.map{$0.idcategoryfood}
                }
            }
        })
    }
    func createfood(){
        viewModel?.createFood().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Food>().map(JSONObject: response.data) {
                    self.viewModel?.datafood.accept(data)
                    JonAlert.showSuccess(message: "Tạo mới thành công")
                    self.dismiss(animated: true)
                }
            }
        })
    }
}

extension DialogCreateFoodViewController: CalculatorMoneyDelegate {
    func presentModalCaculatorInputMoneyViewController() {
            let caculatorInputMoneyViewController = CaculatorInputMoneyViewController()
            
            //phân biệt lúc người dùng đang thao tác trên text_field nào từ đó lấy giá trị hiện của text_field đó
        if let money = self.txt_price.text?.trim().replacingOccurrences(of: ",", with: ""){
            caculatorInputMoneyViewController.result = Int(money == "" ? "0" : money)!
        }

            
            caculatorInputMoneyViewController.limitMoneyFee = 999999999
            caculatorInputMoneyViewController.checkMoneyFee = 100
            caculatorInputMoneyViewController.view.backgroundColor = ColorUtils.blackTransparent()
            let nav = UINavigationController(rootViewController: caculatorInputMoneyViewController)
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
            caculatorInputMoneyViewController.delegate = self
    //        newFeedBottomSheetActionViewController.newFeed = newFeed
    //        newFeedBottomSheetActionViewController.index = position
            present(nav, animated: true, completion: nil)

        }
    
    func callBackCalculatorMoney(amount: Int, position: Int) {
                var data = viewModel?.datafood.value
                txt_price.text = Utils.stringVietnameseFormatWithNumber(amount: amount)
                data?.pricefood = amount
        viewModel?.datafood.accept(data!)
     
        

       
        
    }
}



extension DialogCreateFoodViewController: InputQuantityDelegate {
    func presentModalInputQuantityViewController(number: Float) {
            let dialogInputQuantityViewController = DialogInputQuantityViewController()
            dialogInputQuantityViewController.maxQuantity = 100
        dialogInputQuantityViewController.delegate = self
            dialogInputQuantityViewController.current_quantity = number
          
            dialogInputQuantityViewController.view.backgroundColor = ColorUtils.blackTransparent()
            let nav = UINavigationController(rootViewController: dialogInputQuantityViewController)
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
    
    func callbackInputQuantity(number: Float, position: Int) {
        var data = viewModel?.datafood.value
        data?.quantityfood = Int(number)
        txt_number.text = String(Int(number))
        viewModel?.datafood.accept(data!)
    }
}
extension DialogCreateFoodViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     @objc func openPhotoLibrary() {
           let imagePicker = UIImagePickerController()
           imagePicker.sourceType = .photoLibrary
           imagePicker.delegate = self
           present(imagePicker, animated: true, completion: nil)
       
       }
       
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
               // Lưu ảnh đã chọn vào biến imageView
               image_food.image = selectedImage
               self.imagecover.append(selectedImage)
               imageAvatarFireBase = selectedImage
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


extension DialogCreateFoodViewController {
    func setup() {
        _ = txt_name_food.rx.text.map{(str) in
            if str!.count > 50 {
                JonAlert.showError(message: "Tên food tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Food in
            self.txt_name_food.text = str
            var cloneEmployeeInfor = self.viewModel!.datafood.value
            cloneEmployeeInfor.namefood = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel!.datafood)
        btn_showdropdown.rx.tap.asDriver().drive(onNext: {
            self.txt_dropdownlistcategory.showList()
        })
        txt_dropdownlistcategory.didSelect(completion: {[self] (selectedText,index,id) in
            txt_dropdownlistcategory.text = selectedText
            var data = viewModel?.datafood.value
            data?.idcategoryfood = id
            viewModel?.datafood.accept(data!)
        })
    }
    
    
    private func validate(){
        _ = isNameValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_namefood.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isPricefood.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_price_food.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        _ = isNumberfood.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_number.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
   
        
    }
    
    var isEmployeeInforValid: Observable<Bool>{
        return Observable.combineLatest(isNameValid,isPricefood,isNumberfood,isCategoryFood){$0 && $1 && $2 && $3}
    }
    
    private var isNameValid: Observable<Bool>{
        return viewModel!.datafood.map{$0.namefood}.distinctUntilChanged().asObservable().map(){[self] (str) in
            let name = str.trim()
            lbl_error_namefood.isHidden = false
            
            if name.count < 2{
                lbl_error_namefood.text = "Không được bỏ trống"
                return false
            }
            
            lbl_error_namefood.isHidden = true
            lbl_error_namefood.text = ""
            return true
        }
    }
    
    private var isPricefood: Observable<Bool>{
        return (viewModel?.datafood.map{$0.pricefood}.distinctUntilChanged().asObservable().map(){[self] (str) in
            
            lbl_price_food.isHidden = false
            
            if str == 0 {
                lbl_price_food.text = "Không được bỏ trống"
                return false
            }
            
            lbl_price_food.isHidden = true
            lbl_price_food.text = ""
            return true
        })!

    }
    
    private var isNumberfood: Observable<Bool>{
        return (viewModel?.datafood.map{$0.quantityfood}.distinctUntilChanged().asObservable().map(){[self] (str) in
            
            lbl_error_number.isHidden = false
            
            if str == 0 {
                lbl_error_number.text = "Không được bỏ trống"
                return false
            }
            
            lbl_error_number.isHidden = true
            lbl_error_number.text = ""
            return true
        })!

    }
    private var isCategoryFood: Observable<Bool>{
        return (viewModel?.datafood.map{$0.idcategoryfood}.distinctUntilChanged().asObservable().map(){[self] (str) in
            
            lbl_error_categoryfood.isHidden = false
            
            if str == 0 {
                lbl_error_categoryfood.text = "Không được bỏ trống"
                return false
            }
            
            lbl_error_categoryfood.isHidden = true
            lbl_error_categoryfood.text = ""
            return true
        })!

    }
    
}
