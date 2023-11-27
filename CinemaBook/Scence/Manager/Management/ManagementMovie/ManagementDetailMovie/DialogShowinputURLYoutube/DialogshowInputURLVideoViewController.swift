//
//  DialogshowInputURLVideoViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 27/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import JonAlert

class DialogshowInputURLVideoViewController: UIViewController {

    
    @IBOutlet weak var txt_url: UITextField!
   var viewModel = ManagementDetailMovieViewModel()
    var delegate: callbackurl?
    override func viewDidLoad() {
        super.viewDidLoad()
          
        _ = txt_url.rx.text.map{$0 ?? ""}.bind(to: viewModel.urlvideo)
    }
    @IBAction func btn_access(_ sender: Any) {
        dLog(viewModel.urlvideo.value)
        if (txt_url.text == nil) {
            JonAlert.showError(message: "Vui lòng nhập url của video")
        }else {
            delegate?.callbackurlvideo(url: txt_url.text!)
            dismiss(animated: true)
         
        }
      
    }
    
    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    

}
