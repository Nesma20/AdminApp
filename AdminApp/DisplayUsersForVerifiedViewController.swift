//
//  DisplayUsersForVerifiedViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 5/31/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import  SDWebImage

class DisplayUsersForVerifiedViewController: UITableViewController, UsersListDelegate {
    var adminDelegate:AdminDelegate!
    var users : Array<User> = []
    var userDao = UserDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUsersList()
       
        print("users size \(users.count)")
        
        let  signOutBtn = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.plain, target: self, action: #selector(signOut(sender:)))
        
        self.navigationItem.rightBarButtonItem = signOutBtn
        
adminDelegate.deleteTextFromLogIn()
        
        
    }
    func  signOut(sender: UIBarButtonItem) {
    
        // delete from User Default
        
        
        
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
            self.users = usersList
        self.tableView.reloadData()
            
        })
    }
   
    
    


}
