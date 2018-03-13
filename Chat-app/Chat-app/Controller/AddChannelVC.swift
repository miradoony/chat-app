//
//  AddChannelVC.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 13/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var descriptionTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() 
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func closeChannelModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text , nameTxt.text != "" else {return}
        guard let channelDesc = descriptionTxt.text , descriptionTxt.text != "" else {return}
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func setupView()
    {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:) ))
        bgView.addGestureRecognizer(closeTouch)
    }
    @objc func closeTap (_ reconizer : UITapGestureRecognizer) {
          dismiss(animated: true, completion: nil)
    }
}
