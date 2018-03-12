//
//  PofileVC.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 08/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit

class PofileVC: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }

   
  
    @IBAction func closeBtnPresed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var logoutBtnPressed: UIButton!
    func setupView(){
        nameLbl.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        userImage.image = UIImage(named : UserDataService.instance.avatarName)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(component: UserDataService.instance.avatarColor)
        logoutBtnPressed.addTarget(self, action: #selector(PofileVC.lougout), for: .touchUpInside)
    }

   @objc func lougout()
{UserDataService.instance.logoutUser()
    NotificationCenter.default.post(name: NOTIF_DATA_USER_DID_CHANGE, object: nil)
     dismiss(animated: true, completion: nil)
    }
}
