//
//  ChatMessageRouter.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//



import UIKit

class ChatMessageRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ChatMessageViewController(nibName: "ChatMessageViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func makeToMessageViewController() {
        let messageviewcontroller = MessageRouter().viewController as! MessageViewController
        messageviewcontroller.title = "Nguyenxuantiendung"
        messageviewcontroller.navigationItem.largeTitleDisplayMode = .never
        sourceView?.navigationController?.pushViewController(messageviewcontroller, animated: true)
    }
 
}
