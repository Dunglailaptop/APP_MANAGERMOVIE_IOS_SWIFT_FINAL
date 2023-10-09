//
//  MessageViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 09/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import MessageKit

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
struct Sender: SenderType {
    var photoUrl: String
    var senderId: String
    var displayName: String
}

class MessageViewController: MessagesViewController {

    private var messages = [Message]()
    private let selfSender = Sender(photoUrl: "", senderId: "1", displayName: "NguyenXuanTienDung")
    let customView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Assuming you are inside a UIView subclass
//        customView.backgroundColor = .red
//             customView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//             view.addSubview(customView)
             


        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hello world message. hello world message")))
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.translatesAutoresizingMaskIntoConstraints = false

               // Add constraints
               NSLayoutConstraint.activate([
                   messagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
                   messagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   messagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   messagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
        messagesCollectionView.backgroundColor = ColorUtils.gray_6()
               // Set up your MessageKit code as usual...
           

      
    }


  

}

extension MessageViewController: MessagesDataSource,MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> MessageKit.SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
