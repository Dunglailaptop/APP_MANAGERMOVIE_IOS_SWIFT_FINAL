//
//  SocketIOManager.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 08/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    
    func testSocket(){
        // Create a Socket.IO client instance
        let socket = SocketManager(socketURL: URL(string: "http://your-socket-server-url.com")!, config: [.log(true), .compress])
        let socketClient = socket.defaultSocket

        // Connect to the server
        socketClient.connect()

        // Define event handler for receiving messages from the server
        socketClient.on("Respuesta de SignalR:") { (data, ack) in
            if let response = data[0] as? String {
                dLog("Received message from server: \(response)")
            }
        }

        // Call the EnviarMensaje method
        let user = "John"
        let message = "Hello from Swift"

        socketClient.emit("EnviarMensaje", with: [user, message]) {
            
            // Handle the completion here
        }



    }
    
    var  socketRealTime:SocketIOClient?
    
    func establishConnection() {
      
        socketRealTime?.on("connect") {data, ack in
            dLog("connected==============: \(data.description)")
        }
        
        self.socketRealTime?.connect()

    }
    
    func closeConnection() {
        self.socketRealTime!.disconnect()
        socketRealTime?.on("disconnect") {data, ack in
            dLog("disconnect: \(data.description)")
            
        }
    }
}
