//
//  AvatarCell.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 08/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit
enum AvatarType {
    case dark
    case light
    
}


class AvatarCell: UICollectionViewCell {
    @IBOutlet weak var avatarImg: UIImageView!
    override func awakeFromNib() {
      super.awakeFromNib()
        setUpView()
    }
    
    func configureCell (index : Int , type : AvatarType){
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
    }
    
    func setUpView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
