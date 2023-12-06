//
//  AccountInfoViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import MWPhotoBrowser
import iOSDropDown
import FirebaseAuth
import JonAlert

class AccountInfoViewController: BaseViewController {

    var type_dy = ""
    
    @IBOutlet weak var view_role: UIView!
    @IBOutlet weak var txt_drop_down: DropDown!
    @IBOutlet weak var btn_dropdown: UIButton!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var male: UIImageView!
    
    @IBOutlet weak var female: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    var viewModel = AccountInfoViewModel()
    var router = AccountInfoRouter()
    var userinfo = Users()
    var idUser = 0
    var imagecover = [UIImage]()
     var selectedAssets = [PHAsset]()
    var nameImage: [String] = []
    var imageAvatarFireBase = UIImage()
    @IBOutlet weak var lbl_btn_title: UILabel!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_username: UITextField!
    
    @IBOutlet weak var txt_idUser: UITextField!
    
   
    @IBOutlet weak var txt_address: UITextView!
    
    
    @IBOutlet weak var txt_phone: UITextField!
    
    @IBOutlet weak var txt_birthday: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        checkvaliad()
        self.getListRole()
        // Do any additional setup after loading the view.
    }
    
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
        _ = txt_address.rx.text.map{String($0!.prefix(255))}.map({(str) -> Users in
                            self.txt_address.text = str
                            var clonedata = self.viewModel.dataArray.value
                            clonedata.address = str
                            return clonedata
                }).bind(to: viewModel.dataArray)
        
        _ = btn_dropdown.rx.tap.asDriver().drive(onNext: {
            [self]  in
            self.txt_drop_down.showList()
            }).disposed(by: rxbag)

        txt_drop_down.didSelect{ [self](selectedText , index ,id) in
            var cloneItem = self.viewModel.dataArray.value
            cloneItem.idrole =  id
            self.viewModel.dataArray.accept(cloneItem)
            self.txt_drop_down.text = selectedText
            self.txt_drop_down.selectedIndex = index
                  }
        
           
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       switch type_dy {
                        case "CREATE":
                            view_role.isUserInteractionEnabled = false
                            var id = viewModel.dataArray.value
                            id.idusers = idUser
                            viewModel.dataArray.accept(id)
                            lbl_title.text = "TẠO NHÂN VIÊN MỚI"
                            lbl_btn_title.text = "TẠO NHÂN VIÊN"
                            return
                        case "UPDATE":
                            view_role.isUserInteractionEnabled = false
                            var id = viewModel.dataArray.value
                            id.idusers = idUser
                            viewModel.dataArray.accept(id)
                            lbl_title.text = "CẬP NHẬT NHÂN VIÊN"
                            lbl_btn_title.text = "CẬP NHẬT"
                            getInfoAccount()
                            return
                        case "ACCOUNT":
                           view_role.isUserInteractionEnabled = false
                            var id = viewModel.dataArray.value
                            id.idusers = ManageCacheObject.getCurrentUserInfo().idusers
                            viewModel.dataArray.accept(id)
                            lbl_title.text = "THÔNG TIN TÀI KHOẢN"
                            lbl_btn_title.text = "CẬP NHẬT"
                                getInfoAccount()
                            return
                        default:
                            return
                        }
           
      
      
    }
    

    @IBAction func btn_chooseavatar(_ sender: Any) {
       openPhotoLibrary()
    }
    
   
    @IBAction func btn_chooseBrithday(_ sender: Any) {
        showDateTimePicker(dateTimeData: userinfo.birthday)
    }
  

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    @IBAction func btn_updateAccount(_ sender: Any) {
        if imagecover.count > 0 {
//            createUserFireBase(imageView: imageAvatarFireBase)
            self.postUpdateWithAvatar()
        }else {
            type_dy == "CREATE"  ? self.postCreateEmployee():self.postUpdateAccount()
        }
      
    }
    
    @IBAction func btn_male(_ sender: Any) {
       setupmaleAndFemale(type: 1)
    }
    
    @IBAction func btn_female(_ sender: Any) {
         setupmaleAndFemale(type: 0)
    }
    
    func setupmaleAndFemale(type:Int){
        if type == 1 {
            male.image = UIImage(named: "icon-radio-checked")
                   female.image = UIImage(named: "icon-radio-uncheck")
                   var data = viewModel.dataArray.value
                   data.gender = 1
                   viewModel.dataArray.accept(data)
        }else {
            male.image = UIImage(named: "icon-radio-uncheck")
                         female.image = UIImage(named: "icon-radio-checked")
                   var data = viewModel.dataArray.value
                   data.gender = 0
                   viewModel.dataArray.accept(data)
        }
    }
    
    
}

//CALL CONNECT FIREBASE
extension AccountInfoViewController {
    func createUserFireBase(imageView: UIImage) {
      
           
    
        FireBaseManager.shared.checkExists(email: ManageCacheObject.getCurrentUserInfo().email, password: "123456", imageView: imageView)
    }
    
   
}
