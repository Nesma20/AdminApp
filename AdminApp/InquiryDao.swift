//
//  InquiryDao.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 7/6/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class InquiryDao{

    func getAllInquiries(completionHandler:@escaping (Array<Inquiry>)->Void){
    
        
        var inquiryList = Array<Inquiry>()
        let urlComponents = URLComponents(string: AdminAPI.baseInquiryUrlString + InquiriyQueriesURL.inquiry_list.rawValue)
        
        Alamofire.request((urlComponents?.url!)!).validate().responseJSON{
            response in
            
            switch response.result {
                
            case .success(let value):
                
                let jsonData = JSON(value)
                
                print(jsonData)
                for (index, object) in jsonData {
                    let inquiryData = Inquiry()
                    inquiryData.inquiryId = object["idInquiries"].intValue
                    inquiryData.message = object["message"].stringValue
                    inquiryData.image = object["image"].stringValue
                    inquiryData.status = object["status"].stringValue
                    
           print("\(object["users"]["userName"].stringValue)")
                        inquiryData.user.userName = object["users"]["userName"].stringValue
                        inquiryData.user.email = object["users"]["userEmail"].stringValue
                        for(detailsIndex,detailsObject) in object["users"]["userDetailses"]{
                            inquiryData.user.profileImage = detailsObject["profileImage"].stringValue
                            inquiryData.user.mobileNumber = detailsObject["mobileNumber"].stringValue
                        
                        
                        }
                        
                
                    
                    
                    inquiryList.append(inquiryData)
                }
                
                print("vvvv\(inquiryList.count)")
                completionHandler(inquiryList)
                
            case .failure(let error):
                print(error)
                // in case of no data return
                
                
                completionHandler(inquiryList)
                
                
                
            }
        }
        func changeStatusToRead(inqueryId:Int,completionHandler:(Bool)->Void){
        
        
        
        
        }
    
    
    }


}
