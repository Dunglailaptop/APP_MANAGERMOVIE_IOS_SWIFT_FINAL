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

class DialogManagementCategoryChairViewController: UIViewController, UIColorPickerViewControllerDelegate {

    @IBOutlet weak var btn_show_dropdown: UIButton!
    @IBOutlet weak var txt_drop_down_list: DropDown!
    @IBOutlet weak var lbl_number: UITextField!
    @IBOutlet weak var view_color_chair: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getListRoom()
        btn_show_dropdown.rx.tap.asDriver().drive(onNext: {
            [self] in
            txt_drop_down_list.showList()
        })
        txt_drop_down_list.didSelect{ [self](selectedText , index ,id) in
            txt_drop_down_list.text = selectedText
            var cloneAPIParameter = viewModel?.dataCategoryChair.value
            cloneAPIParameter?.idcategorychair = id
            viewModel?.dataCategoryChair.accept(cloneAPIParameter!)
        }
        // Do any additional setup after loading the view.
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
        dLog(color.toHex())
    }
 

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func btn_access(_ sender: Any) {
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
}

extension DialogManagementCategoryChairViewController: InputQuantityDelegate {
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
       dLog(number)
        lbl_number.text = String(Int(number))
        var data = viewModel?.dataCategoryChair.value
        data?.price = Int(number)
        viewModel?.dataCategoryChair.accept(data!)
        
    }
}
