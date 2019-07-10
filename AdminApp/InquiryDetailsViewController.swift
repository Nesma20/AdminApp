//
//  InquiryDetailsViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 7/6/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit


class InquiryDetailsViewController: UIViewController {
    
    var inquiry = Inquiry()
    
    @IBOutlet weak var userProfileViewImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userEmailLabel: UILabel!

    @IBOutlet weak var inquiryMessageTextView: UITextView!
    
    @IBOutlet weak var inquiryImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        var user = inquiry.user
        usernameLabel.text = user.userName!
        userEmailLabel.text = user.email!
        inquiryMessageTextView.text = inquiry.message!
        
        displayImage(imageURL: inquiry.user.profileImage!, image: userProfileViewImage, typeOfImage: ImageTransformation.profile_r250.rawValue)
        
        displayImage(imageURL: inquiry.image!, image: inquiryImageView, typeOfImage: ImageTransformation.width500.rawValue)
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
