//
//  ImageAPI.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/19/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
enum ImageTransformation: String {
    case original = ""
    case width150 = "w_150/"
    case width500 = "w_500/"
    case profile_r250 = "w_250,h_250,c_fill,r_125/"
}

class ImageAPI {
    private static let key = "hngqi3qgk"
    private static let baseURL = "https://res.cloudinary.com/"
    
    static func getImage(type: ImageTransformation, publicId: String) -> String {
        let imageUrl = "\(baseURL)\(key)/image/upload/"
        return imageUrl + type.rawValue + publicId
    }
    
    }
