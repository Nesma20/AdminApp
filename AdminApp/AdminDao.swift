//
//  AdminDao.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/2/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class AdminDao {
    var myAdmin :Admin = Admin()

    func logIn(email : String , password : String ,completionHandler :@escaping (Bool)->Void){
        
        var userFound : Bool!
        var urlComponents = URLComponents(string: AdminAPI.baseAdminUrlString + AdminURLQueryURL.login.rawValue)
       urlComponents?.queryItems = [URLQueryItem(name: AdminURLQueryURL.email.rawValue , value:email),
                                   URLQueryItem(name: AdminURLQueryURL.password.rawValue , value:password)]
        
        Alamofire.request((urlComponents?.url!)!).validate().responseJSON{
            response in
            
            switch response.result {
            case .success(let data):
                print (data)
             let myJsonData = JSON(data)
             guard let code = myJsonData["code"].int else{
                return
                }
                if(code == 0)
                {
                    userFound = false;
                    print(myJsonData)
                }
                else if code == 1{
                    
                
                  userFound = true
                        self.myAdmin = self.parseAdminData(data: myJsonData["admin"]);
                    print(self.myAdmin.userName ?? "no data");
                    
                    
                }
                completionHandler(userFound)
                
                
            case .failure(let data):
                userFound = false
                print("there is error in connection")
                //print(data)
                completionHandler(userFound)
                
            }
            
            
        }

        
    
    
    }
    func parseAdminData(data:JSON)->Admin{
        let myAdminData :Admin = Admin()
        myAdminData.userName = data["adminName"].string
        myAdminData.email = data["adminEmail"].string
        myAdminData.password = data["adminPassword"].string
        return myAdminData
    }


}
