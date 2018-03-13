 //
//  SocketService.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 13/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit
import SocketIO
class SocketService: NSObject {
 static let instance = SocketService()
    override init() {
        super.init()
    }
   
    let socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    func establishConnection(){
        socket.connect()
    }
    func closeConnection(){
        socket.disconnect()
    }
}
