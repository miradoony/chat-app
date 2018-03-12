//
//  CreateAccountVC.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 06/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != ""{
            userImg.image = UIImage(named: UserDataService.instance.avatarName )
            avatarName =  UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil{
                self.userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    @IBAction func generateBgColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat( arc4random_uniform(255))/255
        let b = CGFloat( arc4random_uniform(255))/255
        self.bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2 ){
            self.userImg.backgroundColor = self.bgColor
            
        }
        
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        guard let name = usernameTxt.text ,usernameTxt.text !=  "" else{return}
        guard let email = emailTxt.text ,emailTxt.text !=  "" else{return}
        guard let pass = passTxt.text , passTxt.text != "" else {return}
        AuthService.instance.registerUSer(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (succes) in
                    AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                        if success {
                            self.spinner.isHidden = true
                            self.spinner.stopAnimating()
                            self.performSegue(withIdentifier: UNWIND, sender: nil)
                            NotificationCenter.default.post(name: NOTIF_DATA_USER_DID_CHANGE,object:nil )
                        }
                    })
                })
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.performSegue(withIdentifier: UNWIND, sender: nil)
    }
    func setUpView(){
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes:[NSAttributedStringKey.foregroundColor: placeHolderColor])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes:[NSAttributedStringKey.foregroundColor: placeHolderColor])
        passTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes:[NSAttributedStringKey.foregroundColor: placeHolderColor])
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap) )
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
}
