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
import youtube_ios_player_helper

class ManagementDetailMovieViewController: BaseViewController {

    @IBOutlet weak var VIEW_SHOW_YT: YTPlayerView!
//    @IBOutlet weak var view_youtube: UIView!
    @IBOutlet weak var txt_dropdown_nation: DropDown!
    var isPlaying = false
       var player: AVPlayer?
       var playerLayer: AVPlayerLayer?
   
    @IBOutlet weak var view_show_video: UIView!
    
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
    //luu anh
    var imagecover = [UIImage]()
     var selectedAssets = [PHAsset]()
    var nameImage: [String] = []
    //luu video
    var videocover = [URL]()
    var nameVideo = [String]()
    var typesave = false
    ///
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

    @IBAction func btn_input_videourl(_ sender: Any) {
        prensentDialogConfirm()
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
        openPhotoLibrary(status: 1)
    }
    
    @IBAction func btn_show_video_phone(_ sender: Any) {
        openPhotoLibrary(status: 2)
    }
    
    @IBAction func btn_choose_api_youtube(_ sender: Any) {
    }
    
    @IBAction func btn_createAndUpdate(_ sender: Any) {
        _ = isEmployeeInforValid.take(1).subscribe(onNext: {[self] (isValid) in
            
            if isValid {
                switch type_check {
                case "CREATE":
                    (imagecover.count > 0) || videocover.count > 0 ? postUpdateWithAvatar():createNewMovie()
                case "DETAIL":
                    (imagecover.count > 0) || videocover.count > 0 ? postUpdateWithAvatar():updatemovie()
                default:
                    return
                }
              
            }
        }).disposed(by: rxbag)
    }
}
extension ManagementDetailMovieViewController: callbackurl {
    func callbackurlvideo(url: String) {
        var urlvideo = url
        var idvideoyoutube = urlvideo.components(separatedBy: "=")
        view_show_video.isHidden = true
        VIEW_SHOW_YT.isHidden = false
        self.VIEW_SHOW_YT.load(withVideoId: idvideoyoutube[1])
        var datamovie = viewModel.dataVideouser.value
        datamovie.videofile = idvideoyoutube[1]
        datamovie.types = 0
        viewModel.dataVideouser.accept(datamovie)
    }
    func prensentDialogConfirm(){
        let dialogConfirm = DialogshowInputURLVideoViewController()
        dialogConfirm.view.backgroundColor = ColorUtils.blackTransparent()
        dialogConfirm.viewModel = viewModel
        dialogConfirm.delegate = self
        
        let nav = UINavigationController(rootViewController: dialogConfirm)
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
