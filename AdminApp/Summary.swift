//
//  Summary.swift
//  AdminApp
//
//  Created by Ahmed M. Hassan on 7/7/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation

struct Summary {
    
    var daily: SummaryDaily?
    var monthly: SummaryMonthly?
    
    var Coupons: [String: Int]?
    var UserReserveCoupon:  [String: Int]?
    var Users: [String: Int]?
    var UserUsedCoupon: [String: Int]?
    
}

struct SummaryMonthly {
    
    var usedCouponsValue: Double?
    var createdCouponsValue: Double?
    var reservedCoupons: Int?
    var registeredUsers: Int?
    var usedCoupons: Int?
    var createdCoupons: Int?
    
}

struct SummaryDaily {
    
    var usedCouponsValue: Double?
    var createdCouponsValue: Double?
    var reservedCoupons: Int?
    var registeredUsers: Int?
    var usedCoupons: Int?
    var createdCoupons: Int?
    
}
