//
//  ChatVC.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 05/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_DATA_USER_DID_CHANGE, object: nil)
                }
            }
            MessageService.instance.findAllChannels { (success) in
                
            }
        }
      
    }
    
    
}
