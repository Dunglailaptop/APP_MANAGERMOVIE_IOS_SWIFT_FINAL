//
//  CreateVoucherViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import Photos
import JonAlert
import ObjectMapper
import RxSwift

class CreateVoucherViewController: BaseViewController {

    @IBOutlet weak var lbl_tittle: UILabel!
    @IBOutlet weak var btn_access: UIButton!
    @IBOutlet weak var lbl_error_note: UILabel!
    @IBOutlet weak var lbl_error_percent: UILabel!
    @IBOutlet weak var lbl_error_namevoucher: UILabel!
    @IBOutlet weak var txt_view_note: UITextView!
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txt_percent: UILabel!
    @IBOutlet weak var txt_price: UITextField!
    @IBOutlet weak var view_percent: UIView!
    @IBOutlet weak var lbl_number_percent: UILabel!
    @IBOutlet weak var lbl_number_pirce: UILabel!
    @IBOutlet weak var icon_percent: UIImageView!
    @IBOutlet weak var icon_price: UIImageView!
    @IBOutlet weak var view_btn_create: UIView!
    var type = DEACTIVE
    var imagecover = [UIImage]()
     var selectedAssets = [PHAsset]()
    var nameImage: [String] = []
    var imageAvatarFireBase = UIImage()
    var viewModel = CreateVoucherViewModel()
    var router = CreateVoucherRouter()
    var checkimage = false
    var checkpercent = false
    var checkPrice = false
    var type_check = ""
    var idvoucher = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        
        view_btn_create.roundCorners([.topLeft,.topRight], radius: 10)
        view_percent.isHidden = true
        setup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch type_check {
        case "CREATE":
            lbl_tittle.text = "TẠO VOUCHER"
            btn_access.setTitle("TẠO MỚI", for: .normal)
        case "UPDATE":
            lbl_tittle.text = "THÔNG TIN VOUCHER"
            btn_access.setTitle("CẬP NHẬT", for: .normal)
            var data = viewModel.dataVoucher.value
            data.idvoucher = idvoucher
            viewModel.dataVoucher.accept(data)
            getDetailVoucher()
        default:
            return
        }
    }


    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    @IBAction func btn_choose_percent(_ sender: Any) {
        type = ACTIVE
        icon_percent.image = UIImage(named: "check")
        icon_price.image = UIImage(named: "icon-check-disable")
        view_percent.isHidden = false
    }
    
    @IBAction func btn_choose_price(_ sender: Any) {
        type = DEACTIVE
        icon_price.image = UIImage(named: "check")
        icon_percent.image = UIImage(named: "icon-check-disable")
        view_percent.isHidden = true
    }
    
    @IBAction func btn_show_price_choose(_ sender: Any) {
        checkPrice = true
        presentModalCaculatorInputMoneyViewController(btnType: "CHOOSE_MONEY")
    }
    @IBAction func btn_show_perce_choose(_ sender: Any) {
      checkpercent = true
        var muner =  Float((self.txt_percent.text?.trim().replacingOccurrences(of: "%", with: ""))!)
         
        presentModalInputQuantityViewController(number: muner!)
    }
    
    @IBAction func btn_show_image(_ sender: Any) {
        checkimage = true
        openPhotoLibrary()
    }
    
    @IBAction func btn_create_voucher(_ sender: Any) {
        isEmployeeInforValid.take(1).subscribe(onNext: {
            [self] isValid in
            if isValid {
                if type_check == "CREATE" {
                    if checkimage && checkpercent || checkPrice {
                        postUpdateWithAvatar()
                       
                        viewModel.makePopToViewController()
                    }else
                    {
                        JonAlert.showError(message: "Vui lòng chọn đầy đủ thông tin")
                    }
                   
                }else {
                    imagecover.count > 0 ?    postUpdateWithAvatar(): updatevoucher()
                    viewModel.makePopToViewController()
                }
              
            }
        }).disposed(by: rxbag)
    }
    
    
}
extension CreateVoucherViewController: CalculatorMoneyDelegate {
    func presentModalCaculatorInputMoneyViewController(btnType:String) {
            let caculatorInputMoneyViewController = CaculatorInputMoneyViewController()
            
            //phân biệt lúc người dùng đang thao tác trên text_field nào từ đó lấy giá trị hiện của text_field đó
            switch btnType {
                case "CHOOSE_MONEY":
                    if let money = self.txt_price.text?.trim().replacingOccurrences(of: ",", with: ""){
                        caculatorInputMoneyViewController.result = Int(money == "" ? "0" : money)!
                    }
                    break
                
                case "CHOOSE_TEM_PRICE":
                    if let money = self.txt_percent.text?.trim().replacingOccurrences(of: ",", with: ""){
                        caculatorInputMoneyViewController.result = Int(money == "" ? "0" : money)!
                    }
                    break
                
                default:
                    return
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
        var data = viewModel.dataVoucher.value
 
            txt_price.text = Utils.stringQuantityFormatWithNumberDouble(amount: Double(String(format: "%d", amount))!)
            data.percent = 0
            data.price = amount
            viewModel.dataVoucher.accept(data)
     
        

       
        
    }
}
extension CreateVoucherViewController: InputQuantityDelegate {
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
        txt_percent.text = String(Int(number)) + "%"
        var data = viewModel.dataVoucher.value
        data.percent = Int(number)
        data.price = 0
        viewModel.dataVoucher.accept(data)
    }
}
extension CreateVoucherViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension CreateVoucherViewController {
    func setup() {
        _ = txt_name.rx.text.map{(str) in
            if str!.count > 50 {
                JonAlert.showError(message: "Tên voucher tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> voucher in
            self.txt_name.text = str
            var cloneEmployeeInfor = self.viewModel.dataVoucher.value
            cloneEmployeeInfor.namevoucher = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.dataVoucher)
        _ = txt_view_note.rx.text.map{(str) in
            if str!.count > 255 {
                JonAlert.showError(message: "Ghi chú tối đa 255 ký tự")
            }
            return String(str!.prefix(255))
        }.map({(str) -> voucher in
            self.txt_view_note.text = str
            var cloneEmployeeInfor = self.viewModel.dataVoucher.value
            cloneEmployeeInfor.note = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.dataVoucher)
    }
    
    
    private func validate(){
        _ = isNameValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_namevoucher.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isNotevalid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_note.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
   
        
    }
    
    var isEmployeeInforValid: Observable<Bool>{
        return Observable.combineLatest(isNameValid,isNotevalid){$0 && $1}
    }
    
    private var isNameValid: Observable<Bool>{
        return viewModel.dataVoucher.map{$0.namevoucher}.distinctUntilChanged().asObservable().map(){[self] (str) in
            let name = str.trim()
            lbl_error_namevoucher.isHidden = false
            
            if name.count < 2{
                lbl_error_namevoucher.text = "Không được bỏ trống"
                return false
            }

            lbl_error_namevoucher.isHidden = true
            lbl_error_namevoucher.text = ""
            return true
        }

    }
    
    private var isNotevalid: Observable<Bool>{
        return viewModel.dataVoucher.map{$0.note}.distinctUntilChanged().asObservable().map(){[self] (str) in
            let name = str.trim()
            lbl_error_note.isHidden = false
            
            if name.count < 2{
                lbl_error_note.text = "Không được bỏ trống"
                return false
            }

            lbl_error_note.isHidden = true
            lbl_error_note.text = ""
            return true
        }

    }
    
  
    
}
