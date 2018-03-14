//
//  MessageService.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 12/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//
import Alamofire
import SwiftyJSON
import Foundation

class MessageService {
    static let instance  = MessageService()
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannels : Channel?
    func findAllChannels(completion : @escaping CompletionHandler)
    {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let  data = response.data else {return }
                do {
                    let json = try JSON(data: data).array
                    for item in json! {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                        
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                    
                }catch let error as NSError {}
                
            }else {
                completion(false)
                debugPrint(response.result.error as? Any)
            }
        }
        
    }
    func clearChannel(){
        channels.removeAll()
    }
    func findAllMessageForChannel (channelId : String, completion: @escaping CompletionHandler){
        
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMsg()
                guard let  data = response.data else {return }
                do {
                    let json = try JSON(data : data).array
                    for item in json! {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        let message = Message(message:messageBody, userName: userName, channelId: channelId, userAvatar:userAvatar,userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                        
                    }
                    print (self.messages)
                    completion(true)
                    
                }catch let error as NSError {}
            }
            else {
                print ("ERRRROOROOROROR")
                completion(false)
                debugPrint(response.result.error as? Any)
            }
        }
        
    }
    func clearMsg(){
        messages.removeAll()
    }
    func clearChannels(){
        channels.removeAll()
    }
    
    
    
    
    
    
    
}





