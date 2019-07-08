//
//  DemoVC.swift
//  AdminApp
//
//  Created by Mohamed Korany Ali on 10/19/1440 AH.
//  Copyright © 1440 AH Jets39. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DemoVC: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var passTxtField: UITextField!
     @IBOutlet weak var txtArea: UITextView!
    

    @IBAction func signInAction(_ sender: Any) {
        
        
        let parameters: [String:String] = ["email" : emailTxtField.text!,
                                           "password" : passTxtField.text!]
        var userFound : Bool!
        
        
        
        
        Alamofire.request("http://graduation.3gb.work/auth/loginapi", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON{
            response in
            
            switch response.result {
            case .success(let data):
                print (data)
                let myJsonData = JSON(data)
                if myJsonData["id"].string != nil {
                    self.txtArea.text=myJsonData["first_name"].string! + myJsonData["last_name"].string!
                    
                    
                }
                
                if let errorMessage = myJsonData["error"].string  {
                    
                    self.txtArea.text=errorMessage
                    
                    
                    
                    
                }
                
                
                
            case .failure(let error):
                userFound = false
                print("there is error in connection")
                print(error)
                
                
                
            }
            
            
        }
        
        

    }
   
}

