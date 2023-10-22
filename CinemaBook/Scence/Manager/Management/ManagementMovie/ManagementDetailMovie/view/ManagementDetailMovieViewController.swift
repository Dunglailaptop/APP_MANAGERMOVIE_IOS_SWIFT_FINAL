//
//  ManagementDetailMovieViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 20/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import iOSDropDown
import JonAlert
import Photos

class ManagementDetailMovieViewController: BaseViewController {

    @IBOutlet weak var txt_dropdown_nation: DropDown!
    
   
    @IBOutlet weak var txt_time_show: UITextField!
    @IBOutlet weak var btn_dropdown_nation: UIButton!
    @IBOutlet weak var btn_dropdowncategorymovie: UIButton!
    @IBOutlet weak var txt_drop_down_categoryMovie: DropDown!
    var viewModel = ManagementDetailMovieViewModel()
    var router = ManagemetDetailMovieRouter()
  
    
    
    @IBOutlet weak var lbl_error_categoryovie: UILabel!
    
    @IBOutlet weak var lbl_error_nation: UILabel!
    
    @IBOutlet weak var lbl_error_dateShowMovie: UILabel!
    
    
    @IBOutlet weak var lbl_error_nameMovie: UILabel!
    
    @IBOutlet weak var lbl_error_author: UILabel!
    
    @IBOutlet weak var lbl_error_alltime: UILabel!
    
    @IBOutlet weak var lbl_error_description: UILabel!
    
    
    @IBOutlet weak var image_poster: UIImageView!
    
    @IBOutlet weak var txt_idmovie: UITextField!
    
    @IBOutlet weak var txt_dateShow: UITextField!
    @IBOutlet weak var txt_namemovie: UITextField!
    
    @IBOutlet weak var txt_author: UITextField!
    @IBOutlet weak var txt_description: UITextView!
    
    @IBOutlet weak var txt_timeShow: UITextField!
    
    
    
    @IBOutlet weak var btn_tiitle_button: UIButton!
    @IBOutlet weak var lbl_tittlle_detial: UILabel!
    var imagecover = [UIImage]()
     var selectedAssets = [PHAsset]()
    var nameImage: [String] = []
    
    var type_check = ""
    var idmovie = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        txt_idmovie.isUserInteractionEnabled = false
        setup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getListNation()
        
        switch type_check {
        case "DETAIL":
            var data = viewModel.valueMovie.value
            data.movieID = idmovie
            viewModel.valueMovie.accept(data)
            getDetailMovie()
            btn_tiitle_button.setTitle("CẬP NHẬT", for: .normal)
            lbl_tittlle_detial.text = "CHI TIẾT PHIM"
        case "CREATE":
            return
        default:
            return
        }
    }


    @IBAction func btn_showDatePicker(_ sender: Any) {
        showDateTimePicker(dateTimeData: "27/09/2023")
    }
    
    
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopTovViewController()
    }
    
    
    @IBAction func btn_showInputQuantity(_ sender: Any) {
        presentModalInputQuantityViewController(position: 1, current_quantity: 130)
    }
    
    @IBAction func btn_showImage_Box(_ sender: Any) {
        openPhotoLibrary()
    }
    
    
    @IBAction func btn_createAndUpdate(_ sender: Any) {
        _ = isEmployeeInforValid.take(1).subscribe(onNext: {[self] (isValid) in
            
            if isValid {
                switch type_check {
                case "CREATE":
                    imagecover.count > 0 ? postUpdateWithAvatar():createNewMovie()
                case "DETAIL":
                    imagecover.count > 0 ? postUpdateWithAvatar():updatemovie()
                default:
                    return
                }
              
            }
        }).disposed(by: rxbag)
    }
}
