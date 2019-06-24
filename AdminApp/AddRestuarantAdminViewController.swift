//
//  AddRestuarantAdminViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/23/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD
class AddRestuarantAdminViewController: UIViewController {
    
    var imgUrl :String!
    var restaurantId :Int!
    var restaurantDao = RestuarantDao()
    @IBOutlet weak var restuarantImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var addNewAdminBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restuarantImageView.image = UIImage(named: imgUrl)
        
        
        
        
        
    }
    
    @IBAction func addNewAdminBtnAction(_ sender: UIButton) {
        addNewAdminBtn.isEnabled = false
        
        guard let adminEmail = emailTextField.text , !adminEmail.isEmpty else {
            SVProgressHUD.dismiss()
            
            errorMessageLabel.text = "Email is required!"
            return
        }
        
        guard let adminPassword = passwordTextField.text ,!adminPassword.isEmpty else {
            SVProgressHUD.dismiss()
            errorMessageLabel.text = "Password is required!"
            return
        }
        
        SVProgressHUD.show()
        let id :String = String(restaurantId)
        restaurantDao.addRestuarantAdmin(restuarantId: id, adminEmail: adminEmail, adminPassword: adminPassword , completionHandler: {(idAdded) in
            SVProgressHUD.dismiss()
            if idAdded {
            SVProgressHUD.showSuccess(withStatus: "Resaurant Admin Added Successfully")
            // return to users table >> home
                
                
            
            }
            else {
                SVProgressHUD.showError(withStatus: "Error While Adding New Admin")
            
            }
            
            
         
        })
            
        
            
        
        addNewAdminBtn.isEnabled = true
        
        
    }
    
    

   
    

    

}
