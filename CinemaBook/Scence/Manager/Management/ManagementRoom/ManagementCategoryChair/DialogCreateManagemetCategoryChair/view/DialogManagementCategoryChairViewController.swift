//
//  DialogManagementCategoryChairViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 24/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import iOSDropDown
import RxSwift
import RxCocoa
import RxRelay
import ObjectMapper
import JonAlert

class DialogManagementCategoryChairViewController: UIViewController, UIColorPickerViewControllerDelegate {

    @IBOutlet weak var btn_access: UIButton!
    @IBOutlet weak var lbl_tittle: UILabel!
    @IBOutlet weak var txt_name_categoryChair: UITextField!
    @IBOutlet weak var btn_show_dropdown: UIButton!
    @IBOutlet weak var txt_drop_down_list: DropDown!
    @IBOutlet weak var lbl_number: UITextField!
    @IBOutlet weak var view_color_chair: UIView!
    var check1 = false
    var check2 = false
    var check3 = false
    var check4 = false
    var delegate: DialogCreateCategoryChair?
    var type = ""
    var idcategory = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getListRoom()
        _ = txt_name_categoryChair.rx.text.map{(str) in
            if str!.count > 50 {
                JonAlert.showError(message: "Độ dài tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> CategoryChair in
            if str.count == 0 {
                self.check4 = false
            }else {
                self.check4 = true
            }
            
            self.txt_name_categoryChair.text = str
            var cloneEmployeeInfor = self.viewModel!.dataCategoryChair.value
            cloneEmployeeInfor.namecategory = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel!.dataCategoryChair)
        btn_show_dropdown.rx.tap.asDriver().drive(onNext: {
            [self] in
            txt_drop_down_list.showList()
        })
        txt_drop_down_list.didSelect{ [self](selectedText , index ,id) in
            
            txt_drop_down_list.text = selectedText
            var cloneAPIParameter = viewModel?.dataCategoryChair.value
            cloneAPIParameter?.idroom = id
            viewModel?.dataCategoryChair.accept(cloneAPIParameter!)
            check1 = true
        }
        lbl_number.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch type {
          case "CREATE":
            lbl_tittle.text = "TẠO LOẠI GHẾ"
            btn_access.setTitle("TẠO MỚI", for: .normal)
          case "DETAIL":
            lbl_tittle.text = "THÔNG TIN LOẠI GHẾ"
            btn_access.setTitle("CẬP NHẬT", for: .normal)
            var data = viewModel?.dataChoose.value
            data?.Idcategory = idcategory
            viewModel?.dataChoose.accept(data!)
            getDetailCategoryChair()
        default:
            return
        }
    }

    @IBAction func btn_show_colorpicket(_ sender: Any) {
      
        if #available(iOS 14.0, *) {
            let color = UIColorPickerViewController()
            color.delegate = self
            present(color, animated: true)
        } else {
            // Fallback on earlier versions
        }
     
    }
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        view_color_chair.backgroundColor = color
        dLog(color)
    }
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        view_color_chair.backgroundColor = color
        var data = viewModel?.dataCategoryChair.value
        data?.colorchair = color.toHex()
        viewModel?.dataCategoryChair.accept(data!)
        check2 = true
        dLog(color.toHex())
    }
 

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func btn_access(_ sender: Any) {
        switch type {
        case "CREATE":
            if check1 && check2 && check3 && check4 {
                var data = viewModel?.dataCategoryChair.value
                delegate?.callbackcreateCategoryChair(categorychairinfo: data!,type: "CREATE")
               
            }else {
                JonAlert.showError(message: "Vui lòng nhập đầy đủ thông tin")
            }
         
        case "DETAIL":
            var data = viewModel?.dataCategoryChair.value
            delegate?.callbackcreateCategoryChair(categorychairinfo: data!,type: "DETAIL")
        default:
            return
        }
      
      
    }
    
    @IBAction func btn_makeToQuantity(_ sender: Any) {
        presentModalInputQuantityViewController(number: 100)
    }
    
    var viewModel: ManagementRoomViewModel? = nil {
        didSet {
            
        }
    }
    
}
extension DialogManagementCategoryChairViewController {
    
  
    func getListRoom() {
        viewModel?.getListRoom().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Room>().mapArray(JSONObject: response.data) {
                    self.txt_drop_down_list.optionArray = data.map{$0.nameroom}
                    self.txt_drop_down_list.optionIds = data.map{$0.idroom}
                }
            }
        })
    }
    func getDetailCategoryChair() {
        viewModel?.getDetailInfoCategoryChair().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<CategoryChair>().map(JSONObject: response.data) {
                    dLog(response.data)
                    self.viewModel?.dataCategoryChair.accept(data)
                    self.setup(data: data)
                }
            }
        })
    }
    func setup(data: CategoryChair) {
        var dats = viewModel?.dataCategoryChair.value
    
        dats?.idcategorychair = data.idcategorychair
        viewModel?.dataCategoryChair.accept(dats!)
        
        txt_name_categoryChair.text = data.namecategory
        view_color_chair.backgroundColor = UIColor(hex: data.colorchair.removeCharacters(from: "#"))
        lbl_number.text = Utils.stringVietnameseFormatWithNumber(amount: data.price)
        txt_drop_down_list.text = data.nameroom
        
    }
}

extension DialogManagementCategoryChairViewController: InputQuantityDelegate {
    func presentModalInputQuantityViewController(number: Float) {
            let dialogInputQuantityViewController = DialogInputQuantityViewController()
            dialogInputQuantityViewController.maxQuantity = 999999
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
       dLog(number)
        lbl_number.text = Utils.stringQuantityFormatWithNumber(amount: Int(number))
        var data = viewModel?.dataCategoryChair.value
        data?.price = Int(number)
        viewModel?.dataCategoryChair.accept(data!)
        check3 = true
    }
}
