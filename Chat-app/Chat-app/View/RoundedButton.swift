//
//  RoundedButton.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 07/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadius : CGFloat = 3.0 {
        didSet {self.layer.cornerRadius = cornerRadius}
    }
    override func awakeFromNib() {
        self.setupView()
    }
    func setupView()
    {
        self.layer.cornerRadius = cornerRadius
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
