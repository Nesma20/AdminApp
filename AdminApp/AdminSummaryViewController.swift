//
//  UserSummaryViewController.swift
//  AdminApp
//
//  Created by Ahmed M. Hassan on 7/7/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD

class AdminSummaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        getSummary()
    }

    private func getSummary() {
        
        SVProgressHUD.show()
        
        AdminDao.getAdminSummary { result in
            
            SVProgressHUD.dismiss()
            
            guard let summary = result else {
                return
            }
            
            
            
        }
    }

}
