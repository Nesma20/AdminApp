//
//  RoundedButoon.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/24/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let cornerRadius = self.bounds.height / 2
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.titleEdgeInsets.left = cornerRadius
        self.titleEdgeInsets.right = cornerRadius
    }
    
}
