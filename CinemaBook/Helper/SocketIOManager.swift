//
//  SocketIOManager.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 08/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//
//import Foundation
//import Starscream
//
//class SignalRManager: WebSocketDelegate {
//    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
//        
//    }
//    
//    var socket: WebSocket!
//
//    func connect() {
//        let url = URL(string: "ws://localhost:5062/kitchen?access_token={{token}}")!
//        socket = WebSocket(request: URLRequest(url: url))
//        socket.delegate = self
//        socket.connect()
//    }
//
//    func websocketDidConnect(socket: WebSocketClient) {
//        dLog("WebSocket connected")
//        // Gửi tin nhắn đến server khi kết nối thành công
//        var request = URLRequest(url: URL(string: "ws://localhost:5062/kitchen?access_token={{token}}")!)
//        let specialChar: Character = "\u{001E}"
//        let initialJSONMessage = "{\"protocol\":\"json\",\"version\":1}" + String(specialChar)
//        let message = "{\"user\":\"Swift\",\"message\":\"Hello from Swift!\"}"
//        socket.write(string: initialJSONMessage)
//    }
//
//    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {}
//
//    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
//        dLog("Received: \(text)")
//        // Xử lý dữ liệu nhận được từ server
//    }
//    
//    
//
//    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
//        dLog("WebSocket disconnected: \(error?.localizedDescription ?? "Unknown error")")
//    }
//}





//import UIKit
//import SocketIO
//import ObjectMapper
//
//class SocketIOManager: NSObject {
//    //singleton
//       private static var shareSocketRealtime: SocketIOManager = {
//           let socketManager = SocketIOManager()
//            return socketManager
//       }()
//    
//    class func shareSocketRealtimeInstance() -> SocketIOManager {
//           return shareSocketRealtime
//       }
//    
//    
//        var managerRealTime: SocketManager?
//        
//        var  socketRealTime:SocketIOClient?
//    
//    override init() {
//        super.init()
//        
//     
//        
//    }
//    
////    func initSocketInstance(_ namespace: String) {
////        
////      
////        self.socketRealTime =  self.managerRealTime!.socket(forNamespace: "RecevieMessage")
////        self.managerRealTime?.connectSocket(self.socketRealTime!)
////        
////        self.socketRealTime?.connect()
////        
////    }
//    
//    func establishConnection() {
//      
//        socketRealTime?.on("RecevieMessage") {data, ack in
//            dLog("connected==============: \(data.description)")
//        }
//        
//        self.socketRealTime?.connect()
//
//    }
//    
//    func closeConnection() {
//        self.socketRealTime!.disconnect()
//        socketRealTime?.on("RecevieMessage") {data, ack in
//            dLog("disconnect: \(data.description)")
//            
//        }
//    }
//    
//
// 
//}
//
//
//class SocketChatIOManager: NSObject {
//    static let sharedInstance = SocketChatIOManager()
//    
//    let manager = SocketManager(socketURL: URL(string: "Http://localhost:5062/kitchen?access_token={{token}}")!, config: [.log(false), .compress])
//   
//    var  socket:SocketIOClient?
//    
//    override init() {
//        super.init()
//        self.socket = manager.defaultSocket
//        
//    }
//    
//    func establishConnection() {
//        self.socket?.connect()
//    }
//    
//
//    func closeConnection() {
//        self.socket!.disconnect()
//    }
//
// 
//}



//import UIKit
//import SocketIO
//
//class SocketIOManager: NSObject {
//    
//    func testSocket(){
//        // Create a Socket.IO client instance
//        let socket = SocketManager(socketURL: URL(string: "Http://localhost:5062/kitchen?access_token={{token}}")!, config: [.log(true), .compress])
//        let socketClient = socket.defaultSocket
//
//        // Connect to the server
//        socketClient.connect()
//
//        // Define event handler for receiving messages from the server
//        socketClient.on("type") { (data, ack) in
//            if let response = data[0] as? String {
//                dLog("Received message from server: \(response)")
//            }
//        }
//        let specialChar: Character = "\u{001E}"
//        let initialJSONMessage = "{\"protocol\":\"json\",\"version\":1}" + String(specialChar)
//
//     
//       
//       
//
//        socketClient.emit("RecevieMessage", with: [initialJSONMessage]) { [self]  in
//            dLog("ket noi thanh cong")
//            self.establishConnection()
//            socketClient.on("type") { (data, ack) in
//                if let response = data[2] as? String {
//                    dLog("Received message from server: \(response)")
//                }
//
//                if let json = data.first as? [String: Any],
//                   let type = json["type"] as? Int,
//                   let target = json["target"] as? String,
//                   let arguments = json["arguments"] as? [String] {
//                       if type == 1 && target == "RecevieMessage" && arguments.count > 0 {
//                           let connectedUser = arguments[0]
//                           dLog("Connected user: \(connectedUser) has connected")
//                           // Xử lý thông điệp kết nối của người dùng ở đây
//                       }
//                    dLog(type)
//                }
//            }
//            // Handle the completion here
//        }
//     
//
//
//
//    }
//    
//    var  socketRealTime:SocketIOClient?
//    
//    func establishConnection() {
//      
//        socketRealTime?.on("RecevieMessage") {data, ack in
//            dLog("connected==============: \(data.description)")
//        }
//        
//        self.socketRealTime?.connect()
//
//    }
//    
//    func closeConnection() {
//        self.socketRealTime!.disconnect()
//        socketRealTime?.on("disconnect") {data, ack in
//            dLog("disconnect: \(data.description)")
//            
//        }
//    }
//}
//import UIKit
//import SocketIO
//
//class SocketIOManager: NSObject {
//    
//    var socket: SocketIOClient?
//    
//    func establishConnection() {
//        // Create a Socket.IO client instance
//        socket = SocketManager(socketURL: URL(string: "Http://localhost:5062/kitchen?access_token={{token}}")!, config: [.log(true), .compress]).defaultSocket
//        
//        // Connect to the server
//        socket?.connect()
//        
//        // Define event handler for receiving messages from the server
//        socket?.on(clientEvent: .connect) { data, ack in
//            // Connected successfully, now send the message
//            self.sendMessageToServer { success in
//                if success {
//                    dLog("Message sent successfully")
//                    // Handle success scenario
//                } else {
//                    dLog("Failed to send message")
//                    // Handle failure scenario
//                }
//            }
//
//        }
//        
//        // Handle possible error scenarios
//        socket?.on(clientEvent: .error) { data, ack in
//            // Handle error situations
//            dLog(data)
//        }
//        
//        // Listen for data from server
//        socket?.on("RecevieMessage") { (data, ack) in
//            // Process received data here
//            if let response = data[0] as? String {
//                dLog("Received message from server: \(response)")
//            }
//        }
//    }
//    
//    func sendMessageToServer(completion: @escaping (Bool) -> Void) {
//        let specialChar: Character = "\u{001E}"
//               let initialJSONMessage = "{\"protocol\":\"json\",\"version\":1}" + String(specialChar)
//        dLog(initialJSONMessage)
//        // Emit the message to the server
//        socket?.emit("RecevieMessage", with: [initialJSONMessage]) {
//            
//        }
//        
//    }
//
//    
//    func closeConnection() {
//        socket?.disconnect()
//    }
//}
import Foundation
import SocketIO
import CoreMedia

class SocketHandler: NSObject {
    static let sharedInstance = SocketHandler()
    let socket = SocketManager(socketURL: URL(string: "http://localhost:5062/kitchen")!,config: [.log(true),.forceWebsockets(true)])
    var mSocket: SocketIOClient!
    
    override init() {
        super.init()
        mSocket = socket.defaultSocket
        dLog(socket)
    }
    func getSocket() -> SocketIOClient {
        return mSocket
    }
    func establishConnection() {
//        mSocket.connect()
        mSocket.connect(timeoutAfter: 0) {
            dLog("2nd Status \(self.socket != nil ? String(describing: self.socket.status) : "Not initialized")")
          
        }
        let specialChar: Character = "\u{001E}"
        let initialJSONMessage = "{\"protocol\":\"json\",\"version\":1}" + String(specialChar)
        self.mSocket.emit("message", initialJSONMessage)
        mSocket.on(clientEvent: .connect) { [weak self] data, ack in
                  dLog("Socket connected")
                 
                
              }
        

              mSocket.on("RecevieMessage") { (dataArray, ack) -> Void in
                  dLog(dataArray)
                  if let receivedData = dataArray.first as? String {
                      dLog("Received data: \(receivedData)")
                      // Xử lý dữ liệu nhận được từ server ở đây
                  }
              }
        mSocket.onAny { (event: SocketAnyEvent) in
                   // Lắng nghe toàn bộ các sự kiện và tin nhắn từ WebSocket
            dLog("Received event: \(event.event), with items: \(event.items)")
               }
    }
    func closeConnection() {
        mSocket.disconnect()
    }
}
