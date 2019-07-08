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
    

}
enum InquiriyQueriesURL :String {

case inquiry_list = "/list"
case change_status = "/change_status"
case inquiry_id = "id"
}
