//
//  DisplayUsersForVerifiedViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 5/31/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import  SDWebImage
import SVProgressHUD
class DisplayUsersForVerifiedViewController: UITableViewController, UsersListDelegate {
    var adminDelegate:AdminDelegate!
    var users : Array<User> = []
    var userDao = UserDao()
    var adminDao = AdminDao()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       
        print("users size \(users.count)")
        
        
         self.navigationItem.hidesBackButton = true
        
    //   let  signOutBtn = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.plain, target: self, action: #selector(signOut(btn:)))
//        let  addRestaurantBtn = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addRestaurantBtn(btn:)))
        let refreshBtn = UIBarButtonItem(title: "Refresh", style: UIBarButtonItemStyle.plain, target: self, action: #selector(refresh(sender:)))
        
        //let addRestaurant = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRestaurantAction(_:)))
//        
//        self.navigationItem.rightBarButtonItem = signOutBtn
//        self.navigationItem.rightBarButtonItem = addRestaurantBtn
//        self.navigationItem.leftBarButtonItem = refreshBtn
        self.navigationItem.leftBarButtonItems?.append(refreshBtn)
        
        
//adminDelegate.deleteTextFromLogIn()
        
        
    }
//    
//    func addRestaurantAction(_ sender: UIBarButtonItem) {
//        let storyboard = UIStoryboard(name: "Restaurants", bundle: nil)
//        let AddResturantVC = storyboard.instantiateViewController(withIdentifier: "restaurantVC") as! AddRestuarantViewController
//        self.navigationController?.pushViewController(AddResturantVC, animated: true)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
         updateUsersList()
       
    }
    
//    func addRestaurantBtn(btn:UIBarButtonItem){
//     let storyboard = UIStoryboard(name: "Restaurants", bundle: nil)
//       let AddResturantVC = storyboard.instantiateViewController(withIdentifier: "restaurantVC") as! AddRestuarantViewController
//        self.navigationController?.pushViewController(AddResturantVC, animated: true)
//        
//        
//    
//    }
    
    func  signOut(btn: UIBarButtonItem) {
    
        // delete from User Default
        adminDao.clearDataFromUserDefault()
        
        // redirct to login page
        let window = UIApplication.shared.keyWindow
        let storyboard
            = UIStoryboard(name: "Main", bundle: nil)
        let LoginVC = storyboard.instantiateViewController(withIdentifier: "loginVCNavigation")
        window?.rootViewController  = LoginVC
        UIView.transition(with: window!, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
        
        
    }
    func refresh(sender:UIBarButtonItem){
    
        updateUsersList()
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count ;
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 ;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForUsers", for: indexPath) as! DisplayUsersTableViewCell
        
        cell.nationalIDLabel.text = users[indexPath.row].nationalID
        cell.userNameLabel.text = users[indexPath.row].userName
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.width / 2
        cell.profileImage.layer.masksToBounds = true
        
        if let image = users[indexPath.row].profileImage, !image.isEmpty {
           cell.profileImage.sd_setShowActivityIndicatorView(true)
            cell.profileImage.sd_setIndicatorStyle(.gray)
           cell.profileImage.sd_setImage(with: URL(string: ImageAPI.getImage(type: .profile_r250, publicId: image)), completed: nil)
        }
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let verificationVC = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationViewController
        verificationVC.userData = users[indexPath.row]
        verificationVC.usersListDelegate = self
        self.navigationController?.pushViewController(verificationVC, animated: true)
    
    }
    func updateUsersList() {
        
        userDao.getAllUsersToBeVerified(completionHandler: {
            (usersList) in
            if usersList.count == 0 {
                SVProgressHUD.showInfo(withStatus: "There are no users to be verified")
            }
            
            
            self.users = usersList
        self.tableView.reloadData()
            
        })
    }
   
   
    


}
