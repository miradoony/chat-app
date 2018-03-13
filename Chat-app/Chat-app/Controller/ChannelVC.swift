//
//  ChannelVC.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 05/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userIImg: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)),name:NOTIF_DATA_USER_DID_CHANGE, object: nil)

        tableView.delegate = self
        tableView.dataSource = self
        SocketService.instance.getChannel { (success) in
            if success{
                self.tableView.reloadData()
            }
            
        }
      
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    @IBAction func addChannel(_ sender: Any) {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
    @IBAction func prepareForUnwind( segue : UIStoryboardSegue ){}
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = PofileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
            
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
    @objc func userDataDidChange (_ notif :Notification){
        setupUserInfo()
    }
    func setupUserInfo()
    {
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal )
            userIImg.image = UIImage(named : UserDataService.instance.avatarName)
            userIImg.backgroundColor = UserDataService.instance.returnUIColor(component: UserDataService.instance.avatarColor)
        }
        else{
            loginBtn.setTitle("Login", for: .normal)
            userIImg.image = UIImage(named : "menuProfileIcon")
            userIImg.backgroundColor = UIColor.clear
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            
            cell.configureCell(channel: channel)
            return cell
        }else {
            return UITableViewCell()
            
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
