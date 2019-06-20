//
//  ViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 5/31/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController ,AdminDelegate{
    
    @IBOutlet weak var emailTextFiled: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var validationLabel: UILabel!
    
    var emailValid, passwordValid : Bool?
    var adminDao = AdminDao()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailValid = false
        passwordValid = false
        loginBtn.isEnabled = false
        
        
    }
    
    @IBAction func emailEditingChangeAction(_ sender: UITextField) {
       
        if(sender.text?.isEmpty)!
        {
        emailValid = false
            validationLabel.text = "Enter Your Email"
            
        }
        else {
        emailValid = true
        }
        enableLoginBtn()
        
        
    }
    
    @IBAction func passwordEditingChangeAction(_ sender: UITextField) {
        
        if(sender.text?.isEmpty)!
        {
            passwordValid = false
            validationLabel.text = "Enter Your Password"
            
        }
        else {
            passwordValid = true
        }
        enableLoginBtn()
        
    }

    func enableLoginBtn (){
    
        if emailValid! && passwordValid! {
        loginBtn.isEnabled = true
        
        }
        else {
            
        loginBtn.isEnabled = false
            
        }
        
        
    }
    

    @IBAction func loginBtnAction(_ sender: Any) {
        
         SVProgressHUD.show()
        
        guard let userEmail = emailTextFiled.text , !userEmail.isEmpty else {
            SVProgressHUD.dismiss()

           // self.signInView.valdiatelabel.text = "Email is required!"
            return
        }
        
        guard let userPassword = passwordTextField.text ,!userPassword.isEmpty else {
            SVProgressHUD.dismiss()
         //   self.signInView.valdiatelabel.text = "Password is required!"
            return
        }

        adminDao.logIn(email : emailTextFiled.text! , password : passwordTextField.text! ,completionHandler :{(userFound) in
             SVProgressHUD.dismiss()
            
            if userFound {
            
            
            print("logged in successfully")
            
            let displayingUsers = self.storyboard?.instantiateViewController(withIdentifier: "displayUserVC") as! DisplayUsersForVerifiedViewController
                displayingUsers.adminDelegate = self
            
            self.navigationController?.pushViewController(displayingUsers, animated: true)
                
            
            }
        else{
          
            
            SVProgressHUD.showError(withStatus: "email OR password isn't correct!")
                
                  print ("Fail while logging in")
            }
        
        })
    
    }
    func deleteTextFromLogIn(){
    emailTextFiled.text! = ""
        passwordTextField.text! = ""
    
    }

}

