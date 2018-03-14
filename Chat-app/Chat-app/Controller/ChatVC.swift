//
//  ChatVC.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 05/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channeSelected(_:)),name:NOTIF_CHANNELS_SELECTED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_DATA_USER_DID_CHANGE, object: nil)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_DATA_USER_DID_CHANGE, object: nil)
                }
            }
        }
      
    }
    @objc func channeSelected (_ notif :Notification){
        updateWithChannel()
    }
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannels?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMsg()
    }
    @objc func userDataDidChange (_ notif :Notification){
        if AuthService.instance.isLoggedIn {
           onLoginGetMessage()
        }else{
           channelNameLbl.text = "Please Log In"
        }
    }
    func onLoginGetMessage(){
        MessageService.instance.findAllChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0{
                    MessageService.instance.selectedChannels = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text  = "No channel"
                }
            }
        }
    }
    func getMsg(){
        guard let channelId =  MessageService.instance.selectedChannels?.id else {return}
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            
            
        }
    }
}
