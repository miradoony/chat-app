//
//  LoginVC.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 06/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    
    @IBAction func loginBtmPresed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        guard let email = userNameTxt.text ,userNameTxt.text != "" else {return}
        guard let pass = passTxt.text ,passTxt.text != "" else {return}
        AuthService.instance.loginUser(email: email, password: pass) {  (success) in
         if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_DATA_USER_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                         self.dismiss(animated: true, completion: nil)

                    }
                })
            }
            
            
        }
      
        
    }
    
    @IBAction func closedPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_REGISTER, sender: self)
    }
    func setupView()
    {
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes:[NSAttributedStringKey.foregroundColor: placeHolderColor])
        passTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes:[NSAttributedStringKey.foregroundColor: placeHolderColor])
        spinner.isHidden = true
    }
    
    
    
}
