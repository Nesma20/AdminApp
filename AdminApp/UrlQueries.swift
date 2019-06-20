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
}
enum UserQueriesURL : String {
case validate = "/verify_or_block"
case getAllUsersWhoWantToBeValidate = "/list_verified"
case user_id = "user_id"
case verified="verified_id"
    
}
