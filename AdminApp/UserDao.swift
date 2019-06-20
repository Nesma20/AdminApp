//
//  UserDao.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/2/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class UserDao{

    func getAllUsersToBeVerified(completionHandler:@escaping (Array<User>)->Void){
    print ("get users data function")
        
    var usersListData = Array<User>()
        let urlComponents = URLComponents(string: AdminAPI.baseUserUrlString + UserQueriesURL.getAllUsersWhoWantToBeValidate.rawValue)
        
        Alamofire.request((urlComponents?.url!)!).validate().responseJSON{
            response in
            
            switch response.result {
                
            case .success(let value):
                
                let jsonData = JSON(value)
                
                print(jsonData)
                for (index, object) in jsonData {
                    let user = User()
                    user.userID = object["userId"].stringValue
                    user.userName = object["userName"].stringValue
                    user.password = object["password"].stringValue
                    user.email = object["userEmail"].stringValue
                    user.verified = object["verified"].intValue
                    
                    
                    for(_,detailsObject) in object["userDetailses"] {
                    
                     print(detailsObject["profileImage"].stringValue)
                        
                        user.profileImage = detailsObject["profileImage"].stringValue
                        user.nationalID = detailsObject["nationalId"].stringValue
                        user.mobileNumber = detailsObject["mobileNumber"].stringValue
                        user.nationalID_Front = detailsObject["nationalIdFront"].stringValue
                        user.nationalID_Back = detailsObject["nationalIdBack"].stringValue
                        user.job = detailsObject["job"].stringValue
                    }
                   usersListData.append(user)
                }
                print("vvvv\(usersListData.count)")
                completionHandler(usersListData)
                
            case .failure(let error):
                print(error)
                // in case of no data return
                
            
                completionHandler(usersListData)
                
                
                
            }
        }

        
    
    
    }


    func verifyOrBlockUser(userId:String,verifyID:Int,completionHandler:@escaping (Bool)->Void){
        var verifiecationCompleted :Bool = false
       
        var urlComponents = URLComponents(string: AdminAPI.baseUserUrlString + UserQueriesURL.validate.rawValue)
        urlComponents?.queryItems = [URLQueryItem(name: UserQueriesURL.user_id.rawValue , value:userId),
                                     URLQueryItem(name: UserQueriesURL.verified.rawValue ,value: "\(verifyID)")]

        Alamofire.request((urlComponents?.url!)!).validate().responseJSON{
            response in
            
            switch response.result {
                
            case .success(let value):
                
                let jsonData = JSON(value)
                if jsonData["code"] == 1 {
                verifiecationCompleted = true
                 
                }
                else
                {
                    
                verifiecationCompleted = false
                    
                }
                
                print(jsonData)
                completionHandler(verifiecationCompleted)
            case .failure(let error):
            print(error)
            completionHandler(verifiecationCompleted)
                
            }
            
            
            
            
            
        }
    }
    
   
}
