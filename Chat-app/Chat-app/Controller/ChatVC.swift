//
//  ChatVC.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 05/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var typinUserLbl: UILabel!
    
    
    var isTyping = false
    @IBOutlet weak var sendBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtn.isHidden = true
        view.bindToKeyboard()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channeSelected(_:)),name:NOTIF_CHANNELS_SELECTED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_DATA_USER_DID_CHANGE, object: nil)
        
        SocketService.instance.getMessage { (success) in
            if success{
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let index = IndexPath(row: MessageService.instance.messages.count-1, section: 0)
                    self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
                }
            }
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannels?.id else {return}
            var names = ""
            var numbersOfTypers = 0
            for (typing,channel) in typingUsers {
                if typing != UserDataService.instance.name && channel == channelId{
                    if names == "" {
                        names = typing
                    }else {
                        names = "\(names), \(typing)"
                    }
                    numbersOfTypers += 1
                }
            }
            if numbersOfTypers > 0 && AuthService.instance.isLoggedIn == true {
               var verb = "is"
                if numbersOfTypers > 1{
                    verb = "are"
                }
                self.typinUserLbl.text = "\(names) \(verb) typing a message"
            }else {
                self.typinUserLbl.text = ""
                
            }
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_DATA_USER_DID_CHANGE, object: nil)
                }
            }
        }
      
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            guard let channelId = MessageService.instance.selectedChannels?.id else {return}
            guard let message = messageTxt.text else {return}
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (succes) in
                if succes {
                    self.messageTxt.text = ""
                  self.messageTxt.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType" ,UserDataService.instance.name,channelId)
                }
            })
        }
        dismissKeyboard()
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
            tableView.reloadData()
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
            if (success){
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard  let channelID = MessageService.instance.selectedChannels?.id else {
            return
        }
        if messageTxt.text == "" {
            isTyping = false
            sendBtn.isHidden = true
            SocketService.instance.socket.emit("stopType" ,UserDataService.instance.name,channelID)
        }
        else {
            if isTyping{
                sendBtn.isHidden = false
                SocketService.instance.socket.emit("startType" ,UserDataService.instance.name,channelID)
            }
            isTyping = true
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}
