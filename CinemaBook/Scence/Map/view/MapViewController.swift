//
//  MapViewController.swift
//  CinemaBook
//
//  Created by dungtien on 7/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import  IQKeyboardManager

class MapViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var txttextview: UITextView!
    @IBOutlet weak var height: NSLayoutConstraint?
    var account:BehaviorRelay<String> = BehaviorRelay(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared().isEnabled = true

        IQKeyboardManager.shared().toolbarTintColor = UIColor.red
        IQKeyboardManager.shared().toolbarDoneBarButtonItemText = "Done"        // Do any additional setup after loading the view.
        height?.constant = txttextview.frame.height
    
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
