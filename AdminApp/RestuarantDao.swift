//
//  RestuarantDao.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/23/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class RestuarantDao {

    func addRestuarant (name:String, city:String, country:String, longitude:String, latitude:String,restaurantImage:String, completionHandler:@escaping (Int)->Void)
    {
        var restaurantId:Int = 0
        
    var urlComponents = URLComponents(string: AdminAPI.baseRestuarantUrlString + RestaurantQueriesURL.add_restuarant.rawValue)
    urlComponents?.queryItems = [URLQueryItem(name: RestaurantQueriesURL.restaurant_name.rawValue , value:name),
    URLQueryItem(name: RestaurantQueriesURL.city.rawValue , value:city),
    URLQueryItem(name: RestaurantQueriesURL.country.rawValue , value:country),
    URLQueryItem(name: RestaurantQueriesURL.longitude.rawValue , value:longitude),
    URLQueryItem(name: RestaurantQueriesURL.latitude.rawValue , value:latitude),
    URLQueryItem(name: RestaurantQueriesURL.restaurant_image.rawValue , value:restaurantImage)]
    
    Alamofire.request((urlComponents?.url!)!).validate().responseJSON{
    response in
    
    switch response.result {
    case .success(let data):
        
    let myJsonData = JSON(data)
    
    print(myJsonData)
    
    guard let code = myJsonData["code"].int else {
        return
    }
    
    restaurantId = myJsonData["id"].intValue
    print("~~~~~~~restaurnt id : \(restaurantId)")
    completionHandler(restaurantId)
        
    case .failure(let error):
        
        print("there is error in connection")
        print(error)
        completionHandler(restaurantId)
        
        
        }
        
        }
    
    }
    func addRestuarantAdmin(restuarantId :String, adminEmail:String,adminPassword:String,completionHandler:@escaping (Bool)->Void){
        
        
        var userFound : Bool!
        var urlComponents = URLComponents(string: AdminAPI.baseAdminUrlString + AdminURLQueryURL.resturant_admin.rawValue)
        urlComponents?.queryItems = [URLQueryItem(name: AdminURLQueryURL.email.rawValue , value:adminEmail),
                                     URLQueryItem(name: AdminURLQueryURL.password.rawValue , value:adminPassword),
                                     URLQueryItem(name: AdminURLQueryURL.restauran_id.rawValue , value:restuarantId)
        ]
        
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
    
    

}
