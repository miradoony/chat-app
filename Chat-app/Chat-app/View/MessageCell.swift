//
//  MessageCell.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 14/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var messageTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell (message : Message){
        messageTxt.text = message.message
        userName.text = message.userName
        userImg.image = UIImage(named : message.userAvatar)
        timeStamp.text = message.timeStamp
        userImg.backgroundColor = UserDataService.instance.returnUIColor(component: message.userAvatarColor)
    }

}
