//
//  UrlQueries.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/16/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation

enum AdminURLQueryURL : String {
    case login = "/validate/login"
    case email = "email"
    case password = "password"
    case resturant_admin = "/add_restaurant_admin"
    case restauran_id="restaurant_id"
    case summary = "/summary"
    case update_restaurant_admin = "/update_restaurant_admin"
    case admin_id = "admin_id"
    
    func url() -> URL {
        return URL(string: AdminAPI.baseAdminUrlString + self.rawValue)!
    }
}

enum UserQueriesURL : String {
    case validate = "/verify_or_block"
    case getAllUsersWhoWantToBeValidate = "/list_verified"
    case user_id = "user_id"
    case verified="verified_id"
}

enum RestaurantQueriesURL : String {
    case add_restuarant="/add_restuarant"
    case restaurant_name="restuarant_name"
    case city="city"
    case country="country"
    case longitude="longitude"
    case latitude="latitude"
    case restaurant_image = "restaurant_image"
    case delete_restaurant = "/delete_restaurant"
    case update_restaurant = "/update_restaurant"
    case restaurant_id = "restuarant_id"
    case list_without_location = "/list_without_location"
    case page = "page"
    
    
}

enum InquiriyQueriesURL :String {    
    case inquiry_list = "/list"
    case update_status = "/update/status"
    case id = "id"
    case is_read = "is_read"
}

