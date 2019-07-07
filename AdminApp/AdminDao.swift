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
                    
                    self.saveInUserDefault()
                    
                    
                }
                completionHandler(userFound)
                
                
            case .failure(let error):
                userFound = false
                print("there is error in connection")
                print(error)
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
    
    
    func saveInUserDefault (){
        UserDefaults.standard.setValue(myAdmin.userName, forKey: adminProperties.adminName.rawValue)
        UserDefaults.standard.setValue(myAdmin.email, forKey: adminProperties.adminEmail.rawValue)
        UserDefaults.standard.setValue(myAdmin.password, forKey: adminProperties.adminPassword.rawValue)
        
    }
    func clearDataFromUserDefault () {
        UserDefaults.standard.removeObject(forKey: adminProperties.adminName.rawValue)
        UserDefaults.standard.removeObject(forKey: adminProperties.adminEmail.rawValue)
        UserDefaults.standard.removeObject(forKey: adminProperties.adminPassword.rawValue)
        
        
    }
    
    
    func checkdataInUserDefault()->Bool{
        
        return UserDefaults.standard.object(forKey: adminProperties.adminEmail.rawValue) != nil
    }
    
    
    
    class func getAdminSummary(completionHandler: @escaping (Summary?) -> Void) {
        
        Alamofire.request(AdminURLQueryURL.summary.url()).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                completionHandler(parseAdminSummary(json["result"]))
                
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    
    private class func parseAdminSummary(_ result: JSON) -> Summary? {
        
        let dailyJson: JSON = result["today"]
        let monthJson: JSON = result["month"]
        let details: JSON = result["details"]
        
        let daily = SummaryDaily(usedCouponsValue: dailyJson["used_coupons_value"].double,
                                 createdCouponsValue: dailyJson["created_coupons_value"].double,
                                 reservedCoupons: dailyJson["reserved_coupons"].int,
                                 registeredUsers: dailyJson["registered_users"].int,
                                 usedCoupons: dailyJson["used_coupons"].int,
                                 createdCoupons: dailyJson["created_coupons"].int)
        
        let monthly = SummaryMonthly(usedCouponsValue: monthJson["used_coupons_value"].double,
                                     createdCouponsValue: monthJson["created_coupons_value"].double,
                                     reservedCoupons: monthJson["reserved_coupons"].int,
                                     registeredUsers: monthJson["registered_users"].int,
                                     usedCoupons: monthJson["used_coupons"].int,
                                     createdCoupons: monthJson["created_coupons"].int)
        
        var coupons = [String: Int]()
        for (key, subJson) in details["Coupons"] {
            coupons[key] = subJson.int
        }
        
        var userReserveCoupon = [String: Int]()
        for (key, subJson) in details["UserReserveCoupon"] {
            userReserveCoupon.updateValue(subJson.int!, forKey: key)
        }
        
        var users = [String: Int]()
        for (key, subJson) in details["Users"] {
            users[key] = subJson.int
        }
        
        var userUsedCoupon = [String: Int]()
        for (key, subJson) in details["UserUsedCoupon"] {
            userUsedCoupon[key] = subJson.int
        }
        
        return Summary(daily: daily,
                              monthly: monthly,
                              Coupons: coupons,
                              UserReserveCoupon: userReserveCoupon,
                              Users: users,
                              UserUsedCoupon: userUsedCoupon)
    }
    
}
enum adminProperties : String {
    case adminName,adminEmail,adminPassword
    
}
