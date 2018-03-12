//
//  GradientView.swift
//  Chat-app
//
//  Created by Mino RANDRIAMANIVO on 06/03/2018.
//  Copyright © 2018 Mino RANDRIAMANIVO. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1){didSet{self.setNeedsLayout()}}
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.5584515759, green: 0.9638821423, blue: 1, alpha: 1){didSet{self.setNeedsLayout()}}
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x:0,y:0)
        gradientLayer.endPoint = CGPoint(x:1,y:1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
