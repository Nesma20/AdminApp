//
//  ReviewTableViewCell.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 7/5/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class UserInquiryTableViewCell : UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
