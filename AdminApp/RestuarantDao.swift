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
    
    guard myJsonData["code"].int != nil else {
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
    
    func getRestaurantsList(pageNumber:Int,completionHandler:@escaping(Array<Restaurant>)->Void){
    
        var restaurantsListData = Array<Restaurant>()
        var urlComponents = URLComponents(string: AdminAPI.baseRestuarantUrlString + RestaurantQueriesURL.list_without_location.rawValue)
        urlComponents?.queryItems = [URLQueryItem(name: RestaurantQueriesURL.page.rawValue , value:String(pageNumber))]
        Alamofire.request((urlComponents?.url!)!).validate().responseJSON{
            response in
            
            switch response.result {
                
            case .success(let value):
                
                let jsonData = JSON(value)
                
                print(jsonData)
                    for (_,restaurantObject) in jsonData["results"]{
                    
                    let restaurantData = Restaurant()
                        let restaurantAdmin : ResturantAdmin = ResturantAdmin()
                        
                        restaurantAdmin.restuarantAdminEmail = restaurantObject["restaurantAdmin"]["restaurantAdminEmail"].stringValue
                        restaurantAdmin.restuarantAdminPassword = restaurantObject["restaurantAdmin"]["restaurantAdminPassword"].stringValue
                        restaurantAdmin.restuarantId = restaurantObject["restaurantAdmin"]["restaurantAdminId"].intValue
                        
                       
                    restaurantData.admin = restaurantAdmin
                        
                        
                    restaurantData.restaurantName = restaurantObject["restaurantName"].stringValue
                    restaurantData.restaurantID = restaurantObject["restaurantID"].intValue
                    restaurantData.city = restaurantObject["city"].stringValue
                    restaurantData.country = restaurantObject["country"].stringValue
                    restaurantData.longitude = restaurantObject["longitude"].doubleValue
                    restaurantData.latitude = restaurantObject["latitude"].doubleValue
                    restaurantData.image = restaurantObject["restaurantImage"].stringValue
                    
                    
                    
                //    for(_,detailsObject) in restaurantObject["restaurantAdmin"] {
                                            restaurantsListData.append(restaurantData)
                        print(" id \(restaurantData.admin?.restuarantId)")
                        print("email \(restaurantData.admin?.restuarantAdminEmail)")
                        
                    }
                    
                    
                
                print("count   \(restaurantsListData.count)")
                completionHandler(restaurantsListData)
                
            case .failure(let error):
                print(error)
                // in case of no data return
                
                
                completionHandler(restaurantsListData)
                
                
                
            }
        }
        

        
    
    
    }
    
    func updateRestaurant(parameters : [String:Any] ,restaurantId :Int,completionHandler:@escaping(Int)->Void){
        
        var urlComponents = URLComponents(string: AdminAPI.baseRestuarantUrlString + RestaurantQueriesURL.update_restaurant.rawValue)
        urlComponents?.queryItems = [URLQueryItem(name: RestaurantQueriesURL.restaurant_id.rawValue , value:String(restaurantId))]
        Alamofire.request(urlComponents!,
                          method: .put,
                          parameters : parameters ,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON {
                            response in
                            switch response.result {
                                
                            case .success(let result):
                                 let jsonData = JSON(result)
                                print(jsonData)
                                let code = jsonData["code"].intValue
                                completionHandler(code)
                                
                               
                            case .failure(let error):
                                print(error)
                                completionHandler(-1)
                                
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
    
    func updateRestaurantAdmin(adminId:Int,parameters:[String:Any],completionHandler:@escaping(Int)->Void){
    
        var urlComponents = URLComponents(string: AdminAPI.baseRestuarantUrlString + AdminURLQueryURL.update_restaurant_admin.rawValue)
        urlComponents?.queryItems = [URLQueryItem(name: AdminURLQueryURL.admin_id.rawValue , value:String(adminId))]
        Alamofire.request(urlComponents!,
                          method: .put,
                          parameters : parameters ,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON {
                            response in
                            switch response.result {
                                
                            case .success(let result):
                                let jsonData = JSON(result)
                                print(jsonData)
                                let code = jsonData["code"].intValue
                                completionHandler(code)
                                
                                
                            case .failure(let error):
                                print(error)
                                completionHandler(-1)
                                
                            }
                            
        }
        
        
    }
    
    func deleteRestaurant(restaurantId:Int,completionHandler:@escaping(Int)->Void){
        var urlComponents = URLComponents(string: AdminAPI.baseRestuarantUrlString + RestaurantQueriesURL.delete_restaurant.rawValue)
        urlComponents?.queryItems = [URLQueryItem(name: RestaurantQueriesURL.restaurant_id.rawValue , value:String(restaurantId))]
        Alamofire.request((urlComponents?.url)!).validate().responseJSON{
            response in
            switch response.result {
                
            case .success(let result):
                let jsonData = JSON(result)
                print(jsonData)
                let code = jsonData["code"].intValue
                completionHandler(code)
                
                
            case .failure(let error):
                print(error)
                completionHandler(-1)
                
            }

        
        }

        
    
    
    }
    
    

}
