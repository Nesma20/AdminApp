//
//  DisplayUsersTableViewCell.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/18/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class DisplayUsersTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var nationalIDLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
