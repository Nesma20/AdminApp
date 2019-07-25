//
//  InquiryDetailsViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 7/6/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class InquiryDetailsViewController: UIViewController {
    
    var inquiry = Inquiry()
    var inquiriesDelegate :InquiriesDelegate?
    @IBOutlet weak var userProfileViewImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userEmailLabel: UILabel!

    @IBOutlet weak var inquiryMessageTextView: UITextView!
    
    @IBOutlet weak var inquiryImageView: UIImageView!
    var inquiryDao = InquiryDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    override func viewWillAppear(_ animated: Bool) {
        let user = inquiry.user
        usernameLabel.text = user.userName!
        userEmailLabel.text = user.email!
        inquiryMessageTextView.text = inquiry.message!
        
        displayImage(imageURL: inquiry.user.profileImage!, image: userProfileViewImage, typeOfImage: ImageTransformation.profile_r250.rawValue)
        
        displayImage(imageURL: inquiry.image!, image: inquiryImageView, typeOfImage: ImageTransformation.width150.rawValue)
        
        inquiryDao.changeStatusToRead(inqueryId: inquiry.inquiryId!, completionHandler: {
            isRead in
            if isRead{
                
                SVProgressHUD.showSuccess(withStatus: "Mark As Read")
            }
            else{
             SVProgressHUD.showError(withStatus: "ErrorWhile Reading ")
            }
            
        })
        
//        self.navigationItem.hidesBackButton = true
//        
//          let  BackBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backToList(btn:)))
//        
//         self.navigationItem.leftBarButtonItems?.append(BackBtn)
        
    }
    func  backToList(btn: UIBarButtonItem) {
       
       let inquiriesListVC = self.storyboard?.instantiateViewController(withIdentifier: "inquiriesListVC") as! InquiriesTableViewController
        self.inquiriesDelegate?.getInquiriesList()
          self.navigationController?.pushViewController(inquiriesListVC, animated: true)
        
    }

    
    func displayImage(imageURL:String,image:UIImageView,typeOfImage :String ){
            image.sd_setShowActivityIndicatorView(true)
            image.sd_setIndicatorStyle(.gray)
            image.sd_setImage(with: URL(string: ImageAPI.getImage(type: ImageTransformation(rawValue: typeOfImage)!, publicId: imageURL)), completed: nil)
        
    
    
    }
  
    

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
