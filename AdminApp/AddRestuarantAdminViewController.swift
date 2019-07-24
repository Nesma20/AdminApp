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
    var adminData = ResturantAdmin()
    var flag :Int!
    @IBOutlet weak var restuarantImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var addNewAdminBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
            restuarantImageView.sd_setShowActivityIndicatorView(true)
        restuarantImageView.sd_setIndicatorStyle(.gray)
        restuarantImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .original, publicId: imgUrl!)), completed: nil)
        
        
        if  flag! == 2 {
        
            updateUI()
        
        }
        
    }
    
    func updateUI (){
    emailTextField.text = adminData.restuarantAdminEmail!
    passwordTextField.text = adminData.restuarantAdminPassword!
        addNewAdminBtn.setTitle("Update", for: .normal)
        
    }
    
    @IBAction func addNewAdminBtnAction(_ sender: UIButton) {
        addNewAdminBtn.isEnabled = false
        
        
        guard let adminEmail = emailTextField.text , !adminEmail.isEmpty else {
            SVProgressHUD.dismiss()
            errorMessageLabel.text = "Email is required!"
             addNewAdminBtn.isEnabled = true
            return
        }
        
        guard let adminPassword = passwordTextField.text ,!adminPassword.isEmpty else {
            SVProgressHUD.dismiss()
            errorMessageLabel.text = "Password is required!"
             addNewAdminBtn.isEnabled = true
            return
        }
        
        
        SVProgressHUD.show()
        
        
         if flag! == 2
        {
        updateAdmin(adminEmail: adminEmail, adminPassword: adminPassword)
        
        }
       else
        {
            addAdmin(adminEmail: adminEmail, adminPassword: adminPassword)
            
        }
        addNewAdminBtn.isEnabled = true
        
        
    }
    
    func updateAdmin(adminEmail:String, adminPassword:String){
        let parameters :[String : Any] = [
            "restaurantAdminEmail": adminEmail,
        "restaurantAdminPassword": adminPassword
        
        ]
        restaurantDao.updateRestaurantAdmin(adminId: adminData.restuarantId!, parameters: parameters, completionHandler: {
             code in
             SVProgressHUD.dismiss()
            
             if code == 0 || code == -1 {
                SVProgressHUD.showError(withStatus: "Error While Updating New Admin")

            
             }else if code == 1{
            
                SVProgressHUD.showSuccess(withStatus: "Restaurant Admin Updated Successfully")
                self.moveToRestaurantList()
             }
        
        
        })
        
        
    }
    
    
    func addAdmin(adminEmail:String, adminPassword:String ){
    
    
        let id :String = String(restaurantId)
        restaurantDao.addRestuarantAdmin(restuarantId: id, adminEmail: adminEmail, adminPassword: adminPassword , completionHandler: {(idAdded) in
            SVProgressHUD.dismiss()
            if idAdded {
                
                //MARK:-return to restaurants table
                
                SVProgressHUD.showSuccess(withStatus: "Restaurant Admin Added Successfully")
                self.moveToRestaurantList()
               
                
            }
            else {
                SVProgressHUD.showError(withStatus: "Error While Adding New Admin")
                
                
            }
            
            
            
            
        })
    }
    
    func moveToRestaurantList(){
        
//        let restaurantsListVC = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantsNavVC")
        
        self.navigationController?.popToRootViewController(animated: true)
    
    }
    
    

   
    

    

}
