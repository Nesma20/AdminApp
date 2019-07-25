//
//  RoundImageView.swift
//  dryv
//
//  Created by Ahmed M. Hassan on 7/13/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }

}
