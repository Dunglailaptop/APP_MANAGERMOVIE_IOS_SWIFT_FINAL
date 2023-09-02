//
//  AccountInfoViewController.swift
//  CinemaBook
//
//  Created by dungtien on 9/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import MWPhotoBrowser

class AccountInfoViewController: BaseViewController {

    @IBOutlet weak var avatar: UIImageView!
    var viewModel = AccountInfoViewModel()
    var router = AccountInfoRouter()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
    }

    @IBAction func btn_chooseavatar(_ sender: Any) {
       openPhotoLibrary()
    }
    
    var photos: [MWPhoto] = []

       // Function to open the MWPhotoBrowser
       func openPhotoBrowser() {
           let browser = MWPhotoBrowser(photos: photos)
        browser?.displayActionButton = true
        browser?.displayNavArrows = true
        browser?.zoomPhotosToFill = true
        browser?.enableSwipeToDismiss = true
        
           // Customize other properties as needed

        navigationController?.pushViewController(browser!, animated: true)
        browser?.showNextPhoto(animated: true)
        browser?.showPreviousPhoto(animated: true)
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AccountInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
           }
           picker.dismiss(animated: true, completion: nil)
       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}
